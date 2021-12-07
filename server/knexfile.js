const path = require('path')

const commonConfig = {
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

module.exports = {
    development: commonConfig,
    production: commonConfig,
}