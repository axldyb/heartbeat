import * as ipInfo from 'ipinfo'
import { Logger } from './utils/logger'

export interface IpInfo {
    ip: string
    city: string
    region: string
    country: string
    loc: string
    org: string
    postal: string
    timezone: string
}

export class IpInfoService {

    private logger = new Logger('IpInfoService')

    public async getIpInfo(ip: string): Promise<IpInfo | null> {
        try {
            const info = await ipInfo(ip, process.env.IPINFO_API_TOKEN)
            this.logger.info('IP info: ' + JSON.stringify(info, null, 2))

            if (info.bogon) {
                this.logger.info('IP info: BOGON')
                return null
            }

            return info
        } catch (error) {
            this.logger.error('Error getting IP info: ' + error)
            return null
        }
    }

    // Input in the format like 'ipv4:195.139.151.210:54070'
    public extractIp(input: string): string {
        return input.split(':')[1] || ''
    }
}