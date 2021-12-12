import * as knex from 'knex'
import { Heartbeat } from '../proto/heartbeat/Heartbeat'
import { Timestamp } from 'google-protobuf/google/protobuf/timestamp_pb'
import { Logger } from './utils/logger'
import { newHeartbeat } from '../proto/heartbeat/newHeartbeat'
import { IpInfo } from './ip-info-service'

const logger = new Logger('HeartbeatSerializer')
const MISSING_VALUE = 'MISSING_VALUE'

export class HeartbeatSerializer {

    static serializeNewHeartbeatToDatabaseObject(db: knex, heartbeat: newHeartbeat, ipInfo: IpInfo | null): object | null {
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

        const lat = ipInfo?.loc ? ipInfo.loc.split(',')[0] : MISSING_VALUE
        const long = ipInfo?.loc ? ipInfo.loc.split(',')[1] : MISSING_VALUE

        const data = {
            client_id: client.id || MISSING_VALUE,
            client_name: client.name || MISSING_VALUE,
            client_version: client.version || MISSING_VALUE,
            device_id: device.id || MISSING_VALUE,
            device_name: device.name || MISSING_VALUE,
            device_os: device.os || MISSING_VALUE,
            device_os_version: device.osVersion || MISSING_VALUE,
            device_model: device.model || MISSING_VALUE,
            device_language: device.language || MISSING_VALUE,
            ip: ipInfo?.ip || null,
            city: ipInfo?.city || null,
            region: ipInfo?.region || null,
            country: ipInfo?.country || null,
            coordinates: ipInfo?.loc ? db.raw(`point(${long}, ${lat})`) : null,
            org: ipInfo?.org || null,
            postal: ipInfo?.postal || null,
            timezone: ipInfo?.timezone || null,
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
            },
            location: {
                city: dbObject.city,
                region: dbObject.region,
                country: dbObject.country,
                latitude: dbObject.coordinates ? dbObject.coordinates.y : null,
                longitude: dbObject.coordinates ? dbObject.coordinates.x : null,
                org: dbObject.org,
                postal: dbObject.postal,
                timezone: dbObject.timezone,
            }
        }
        return heartbeat
    }
}