require('dotenv').config()
const express = require('express'),
          chalk = require('chalk'),
          config = require('../config.json')[process.env.NODE_ENV],
          setup = require('./middleware_setup'),
          routes = require('./routes'),
          app = express();


app.set('config', config)
setup(app)
routes(app)


app.listen(config.server_port, () => {
    console.log(`PATH: ${chalk.yellow(__dirname.split('/').splice(7,).join('/'))} | ENV: ${chalk.magenta(process.env.NODE_ENV)} | PORT: ${chalk.cyan(config.server_port)} | STATUS: ${chalk.greenBright('running')}`)
})