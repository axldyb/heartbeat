import { Heartbeat } from '../proto/heartbeat/Heartbeat'
import { Timestamp } from 'google-protobuf/google/protobuf/timestamp_pb'
import { Logger } from './utils/logger'

const logger = new Logger('HeartbeatSerializer')

export class HeartbeatSerializer {

    static serializeHeartbeatToDatabaseObject(heartbeat: Heartbeat): object | null {
        const client = heartbeat.client
        if (!client) {
            logger.error('missing client on heartbeat')
            return null
        }

        const device = heartbeat.device
        if (!device) {
            logger.error('missing device on heartbeat')
            return null
        }

        const data = {
            client_id: client.id || 'MISSING_VALUE',
            client_name: client.name || 'MISSING_VALUE',
            client_version: client.version || 'MISSING_VALUE',
            device_id: device.id || 'MISSING_VALUE',
            device_name: device.name || 'MISSING_VALUE',
            device_os: device.os || 'MISSING_VALUE',
            device_os_version: device.osVersion || 'MISSING_VALUE',
            device_model: device.model || 'MISSING_VALUE',
            device_language: device.language || 'MISSING_VALUE'
        }

        return data
    }

    static serializeDatabaseObjectToHeartbeat(dbObject: any): Heartbeat | null {
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