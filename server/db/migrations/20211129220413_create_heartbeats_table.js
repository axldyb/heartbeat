
exports.up = function (knex, Promise) {
    return knex.schema.createTable('heartbeats', function (table) {
        table.uuid('id').primary().defaultTo(knex.raw("gen_random_uuid()"))
        table.timestamp('timestamp').defaultTo(knex.fn.now())
        table.string('client_id', 255).notNullable()
        table.string('client_name', 255).notNullable()
        table.string('client_version', 255).notNullable()
        table.string('device_id', 255).notNullable()
        table.string('device_name', 255).notNullable()
        table.string('device_os', 255).notNullable()
        table.string('device_os_version', 255).notNullable()
        table.string('device_model', 255).notNullable()
        table.string('device_language', 255).notNullable()
    })
}

exports.down = function (knex, Promise) {
    return knex.schema.dropTable('heartbeats')
}
