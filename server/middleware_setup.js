const bodyParser = require('body-parser')
        , cors = require('cors')
        , massive = require('massive')

        
module.exports = function(app) {
    const config = app.get('config')

    app.use(bodyParser.json())
    app.use(cors())
    massive(config.db_url).then(db => app.set('db', db))
}