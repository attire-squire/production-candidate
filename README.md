# ATTIRE SQUIRE

### Config.json

{
    "development": {
        "client_url": string,
        "server_url": string,
        "server_port": number,
        "db_url": string,
        "twilio_account": "string,
        "twilio_key": "string
        "twilio_number": string or number
    },
    "production": {
        "client_url": string
        "server_url": string,
        "server_port": number,
        "db_url": string (add `?ssl=true`),
        "twilio_account": string,
        "twilio_key": string,
        "twilio_number": string or number
    }
}