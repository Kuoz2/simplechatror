process.env.NODE_ENV = process.env.NODE_ENV || 'development'

const environment = require('./environment')

const config = environment.toWebpackConfig()
config.mode = 'development' // Asegúrate de establecer el modo adecuado

module.exports = config