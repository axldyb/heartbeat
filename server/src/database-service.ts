import * as path from 'path'
import * as knex from 'knex'
import { Heartbeat } from '../proto/heartbeat/Heartbeat'
import { Timestamp } from 'google-protobuf/google/protobuf/timestamp_pb'
// import * as knexConfig from '../knexfile'

// const knexConfig = require('../')

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
}

export class DatabaseService {

    private databaseClient: knex

    constructor(environment: Environment) {
        const config = knexConfig[environment]
        this.databaseClient = knex(config)
    }

    public async getHeartbeats(): Promise<Heartbeat[]> {
        const heartbeats = await this.databaseClient(TableName.heartbeats)
        return heartbeats.map(this.mapDBObjectToHeartbeat)
    }

    private mapDBObjectToHeartbeat(dbObject: any): Heartbeat {
        console.log('dbObject: ' + JSON.stringify(dbObject, null, 2))

        const date = new Date(dbObject.timestamp)
        console.log('date: ' + date)

        const timestamp = new Timestamp()
        timestamp.fromDate(date)

        console.log('timestamp: ' + timestamp)

        const heartbeat: Heartbeat = {
            id: dbObject.id,
            timestamp: timestamp,
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
