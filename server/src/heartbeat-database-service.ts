import * as path from 'path'
import * as knex from 'knex'
import { Heartbeat } from '../proto/heartbeat/Heartbeat'
import { HeartbeatId } from '../proto/heartbeat/HeartbeatId'
import { newHeartbeat } from '../proto/heartbeat/newHeartbeat'
import { HeartbeatSerializer } from './heartbeat-serializer'
import { Logger } from './utils/logger'
import * as knexConfig from '../knexfile'

export enum Environment {
    development = 'development',
    production = 'production'
}

export enum TableName {
    heartbeats = 'heartbeats'
}

export class HeartbeatDatabaseService {

    private databaseClient: knex
    private logger = new Logger('HeartbeatDatabaseService')

    constructor(environment: Environment) {
        const config = knexConfig[environment]
        this.databaseClient = knex(config)
    }

    public async getHeartbeats(): Promise<Heartbeat[]> {
        const heartbeats = await this.databaseClient(TableName.heartbeats)
        return heartbeats.map(HeartbeatSerializer.serializeDatabaseObjectToHeartbeat)
    }

    // TODO: Use result type with error handling...
    public async getHeartbeat(heartbeatId: HeartbeatId): Promise<Heartbeat | null> {
        if (!heartbeatId.id) {
            this.logger.error(`Invalid heartbeat id provided: ${JSON.stringify(heartbeatId, null, 2)}`)
            return null
        }

        const data = await this.databaseClient(TableName.heartbeats).where({ id: heartbeatId.id })
        if (data.length) {
            const heartbeat = HeartbeatSerializer.serializeDatabaseObjectToHeartbeat(data[0])
            return heartbeat
        } else {
            this.logger.warning(`Heartbeat with ID ${heartbeatId.id} does not exist`)
            return null
        }
    }

    public async createHeartbeat(newHeartbeat: newHeartbeat): Promise<boolean> {
        if (!newHeartbeat) {
            this.logger.error(`Invalid heartbeat provided: ${JSON.stringify(newHeartbeat, null, 2)}`)
            return false
        }

        const data = HeartbeatSerializer.serializeHeartbeatToDatabaseObject(newHeartbeat)

        await this.databaseClient(TableName.heartbeats).insert(data)

        return true
    }

    public async countHeartbeats(): Promise<number> {
        const result = await this.databaseClient(TableName.heartbeats).count()
        return result[0] ? result[0].count : 0
    }
}
