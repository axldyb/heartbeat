import Ajv, { ErrorObject } from "ajv"
import addFormats from "ajv-formats"

export class SchemaValidator {

    private ajv = new Ajv({ allErrors: true })

    constructor() {
        addFormats(this.ajv)
    }

    /**
     * Validate an object against a Json Schema
     * @param schema Json schema to validate against. Will throw exception if schema is invalid
     * @param jsonToValidate object to validate
     */
    validateJson(schema: { [requestProperty: string]: {} }, jsonToValidate: {}): ErrorObject[] | undefined | null {
        const validateFunc = this.ajv.compile(schema)
        validateFunc(jsonToValidate) // Side effects: sets validateFunc.errors
        return validateFunc.errors
    }

    /**
     * Convert AJV validation error object to human-readable object
     */
    prettifyJsonSchemaError(ajvErrors: ErrorObject[]): [string, string][] {
        const errors: [string, string][] = []

        for (const error of ajvErrors) {
            // TODO: empty datapath may noe always mean request
            const errorKey = error.instancePath === "" ? "request" : error.instancePath.replace(/^./, "")

            // Dirty way of making sure message is a string
            errors.push([errorKey, "" + error.message])
        }

        return errors
    }

    /**
     * Convert AJV validation error object to human-readable string
     */
    prettifyJsonSchemaErrorToString(ajvErrors: ErrorObject[]): string {
        let errors = ''
        for (const error of ajvErrors) {
            const errorKey = error.instancePath === "" ? "request" : error.instancePath.replace(/^./, "")
            let errorMessage = error.message
            if (error.params.additionalProperty) {
                errorMessage += ` ${error.params['additionalProperty']}`
            }
            // Dirty way of making sure message is a string
            errors += `${errorKey}: ${errorMessage}, `
        }

        return errors
    }

}