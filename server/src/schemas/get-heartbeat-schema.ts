export const getHeartbeatSchema: { [requestProperty: string]: {} } = {
    $schema: "http://json-schema.org/schema#",
    type: 'object',
    properties: {
        id: {
            type: 'number',
            minimum: 1,
            maximum: Number.MAX_SAFE_INTEGER
        },
    },
    required: ['id']
}