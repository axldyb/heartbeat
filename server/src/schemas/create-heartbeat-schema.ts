export const createHeartbeatSchema: { [requestProperty: string]: {} } = {
    $schema: "http://json-schema.org/schema#",
    type: 'object',
    properties: {
        client: {
            type: 'object',
            properties: {
                id: {
                    type: 'string',
                    minLength: 1,
                    maxLength: 128,
                },
                name: {
                    type: 'string',
                    minLength: 2,
                    maxLength: 128,
                },
                version: {
                    type: 'string',
                    minLength: 1,
                    maxLength: 128,
                },
            },
            required: ['id', 'name', 'version'],
            additionalProperties: false
        },
        device: {
            type: 'object',
            properties: {
                id: {
                    type: 'string',
                    minLength: 1,
                    maxLength: 128,
                },
                name: {
                    type: 'string',
                    minLength: 1,
                    maxLength: 128,
                },
                os: {
                    type: 'string',
                    minLength: 1,
                    maxLength: 128,
                },
                osVersion: {
                    type: 'string',
                    minLength: 1,
                    maxLength: 128,
                },
                model: {
                    type: 'string',
                    minLength: 1,
                    maxLength: 128,
                },
                language: {
                    type: 'string',
                    minLength: 1,
                    maxLength: 128,
                },
            },
            required: ['id', 'name', 'os', 'osVersion', 'model', 'language'],
            additionalProperties: false
        },
    },
    required: ['client', 'device'],
    additionalProperties: false
}