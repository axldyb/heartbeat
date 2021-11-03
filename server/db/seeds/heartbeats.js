const uuid = require('uuid')

exports.seed = function (knex, Promise) {
  // Deletes ALL existing entries
  return knex('heartbeats').del()
    .then(function () {
      // Inserts seed entries
      return knex('heartbeats').insert([
        {
          client_id: 'heartbeat.axldyb.com.ios',
          client_name: 'My iOS app',
          client_version: '1.0.0',
          device_id: uuid.v4(),
          device_name: 'iOS Device 1',
          device_os: 'iOS',
          device_os_version: '15.0.1',
          device_model: 'iPhone 5,6',
          device_language: 'no_nb'
        },
        {
          client_id: 'heartbeat.axldyb.com',
          client_name: 'My Website',
          client_version: '1.0.0',
          device_id: uuid.v4(),
          device_name: 'MBP15',
          device_os: 'OSX',
          device_os_version: '11.6',
          device_model: 'Macbook Pro 16',
          device_language: 'no_nb'
        }
      ])
    })
}