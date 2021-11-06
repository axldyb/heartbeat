export class Logger {

    private loggerName: string

    constructor(name: string) {
        this.loggerName = name
    }

    public info(message: string): void {
        console.info(`${new Date().toISOString()} [${this.loggerName}] ${message}`)
    }

    public debug(message: string): void {
        console.debug(`${new Date().toISOString()} [${this.loggerName}] ${message}`)
    }

    public warning(message: string): void {
        console.warn(`${new Date().toISOString()} [${this.loggerName}] ${message}`)
    }

    public error(message: string | Error): void {
        const errorMessage = message instanceof Error ? message.toString() : message
        console.info(`${new Date().toISOString()} [${this.loggerName}] ${errorMessage}`)
    }
}