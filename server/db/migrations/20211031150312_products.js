exports.up = function (knex, Promise) {
    return knex.schema.createTable('heartbeats', function (table) {
        table.increments()
        table.timestamp('timestamp').defaultTo(knex.fn.now())
        table.string('client_id').notNullable()
        table.string('client_name').notNullable()
        table.string('client_version').notNullable()
        table.string('device_id').notNullable()
        table.string('device_name').notNullable()
        table.string('device_os').notNullable()
        table.string('device_os_version').notNullable()
        table.string('device_model').notNullable()
        table.string('device_language').notNullable()
    })
}

exports.down = function (knex, Promise) {
    return knex.schema.dropTable('heartbeats')
}