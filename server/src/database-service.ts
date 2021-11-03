import * as path from 'path'
import * as knex from 'knex'
import { Heartbeat } from '../proto/heartbeat/Heartbeat'
import { Timestamp } from 'google-protobuf/google/protobuf/timestamp_pb'
import { HeartbeatId } from '../proto/heartbeat/HeartbeatId'
import { newHeartbeat } from '../proto/heartbeat/newHeartbeat'

const knexConfig = {
    development: {
        client: 'postgresql',
        connection: {
            host: 'postgres',
            user: 'postgres',
            password: 'postgres',
            port: '5432',
            database: 'heartbeat',
        },
        pool: {
            min: 2,
            max: 10,
        },
        migrations: {
            directory: path.join(__dirname, 'db', 'migrations'),
        },
        seeds: {
            directory: path.join(__dirname, 'db', 'seeds'),
        },
    }
}

export enum Environment {
    development = 'development'
}

export enum TableName {
    heartbeats = 'heartbeats'
}

export interface DatabaseManager {
    getHeartbeats(): Promise<Heartbeat[]>
    getHeartbeat(id: HeartbeatId): Promise<Heartbeat | null>
    createHeartbeat(newHeartbeat: newHeartbeat): Promise<boolean>
}

export class DatabaseService implements DatabaseManager {

    private databaseClient: knex

    constructor(environment: Environment) {
        const config = knexConfig[environment]
        this.databaseClient = knex(config)
    }

    public async getHeartbeats(): Promise<Heartbeat[]> {
        const heartbeats = await this.databaseClient(TableName.heartbeats)
        return heartbeats.map(this.mapDBObjectToHeartbeat)
    }

    // TODO: Use result type with error handling...
    public async getHeartbeat(heartbeatId: HeartbeatId): Promise<Heartbeat | null> {
        if (!heartbeatId.id) {
            console.error(`Invalid heartbeat id provided: ${JSON.stringify(heartbeatId, null, 2)}`)
            return null
        }

        const data = await this.databaseClient(TableName.heartbeats).where({ id: heartbeatId.id })
        if (data.length) {
            const heartbeat = this.mapDBObjectToHeartbeat(data[0])
            return heartbeat
        } else {
            console.log(`Heartbeat with ID ${heartbeatId.id} does not exist`)
            return null
        }
    }

    public async createHeartbeat(newHeartbeat: newHeartbeat): Promise<boolean> {
        if (!newHeartbeat) {
            console.error(`Invalid heartbeat provided: ${JSON.stringify(newHeartbeat, null, 2)}`)
            return false
        }

        const data = {
            client_id: newHeartbeat.client?.id || 'MISSING_VALUE',
            client_name: newHeartbeat.client?.name || 'MISSING_VALUE',
            client_version: newHeartbeat.client?.version || 'MISSING_VALUE',
            device_id: newHeartbeat.device?.id || 'MISSING_VALUE',
            device_name: newHeartbeat.device?.name || 'MISSING_VALUE',
            device_os: newHeartbeat.device?.os || 'MISSING_VALUE',
            device_os_version: newHeartbeat.device?.osVersion || 'MISSING_VALUE',
            device_model: newHeartbeat.device?.model || 'MISSING_VALUE',
            device_language: newHeartbeat.device?.language || 'MISSING_VALUE'
        }

        console.log('data: ' + JSON.stringify(data, null, 2))

        await this.databaseClient(TableName.heartbeats).insert(data)
        return true
    }

    private mapDBObjectToHeartbeat(dbObject: any): Heartbeat {
        const date = new Date(dbObject.timestamp)
        const timestamp = new Timestamp()
        timestamp.fromDate(date)

        const heartbeat: Heartbeat = {
            id: dbObject.id,
            timestamp: timestamp.toObject(),
            client: {
                id: dbObject.client_id,
                name: dbObject.client_name,
                version: dbObject.client_version,
            },
            device: {
                id: dbObject.device_id,
                name: dbObject.device_name,
                os: dbObject.device_os,
                osVersion: dbObject.device_os_version,
                model: dbObject.device_model,
                language: dbObject.device_language
            }
        }
        return heartbeat
    }
}
