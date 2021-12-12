
exports.up = function (knex, Promise) {
    return knex.schema.table('heartbeats', function (table) {
        table.string('ip', 255)
        table.string('city', 255)
        table.string('region', 255)
        table.string('country', 255)
        table.specificType('coordinates', 'POINT')
        table.string('org', 255)
        table.string('postal', 255)
        table.string('timezone', 255)
    })
}

exports.down = function (knex, Promise) {
    return knex.schema.table('heartbeats', function (table) {
        table.dropColumn('ip')
        table.dropColumn('city')
        table.dropColumn('region')
        table.dropColumn('country')
        table.dropColumn('coordinates')
        table.dropColumn('org')
        table.dropColumn('postal')
        table.dropColumn('timezone')
    })
}
