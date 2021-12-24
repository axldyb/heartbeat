const path = require('path')

const commonConfig = {
    client: 'postgresql',
    connection: {
        host: 'postgres',
        user: process.env.POSTGRES_USER || '',
        password: process.env.POSTGRES_PASSWORD || '',
        port: process.env.POSTGRES_PORT || '',
        database: process.env.POSTGRES_DB || '',
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

module.exports = {
    development: commonConfig,
    production: commonConfig,
}