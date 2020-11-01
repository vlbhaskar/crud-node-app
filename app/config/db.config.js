const env = require('./env.js');

const Sequelize = require('sequelize');
const DataTypes = require('sequelize/lib/data-types')
const sequelize = new Sequelize(env.database, env.username, env.password, {
  host: env.host,
  dialect: env.dialect,
  dialectOptions: env.dialectOptions,
  operatorsAliases: false,

  pool: {
    max: env.max,
    min: env.pool.min,
    acquire: env.pool.acquire,
    idle: env.pool.idle
  }
});

const db = {};

db.Sequelize = Sequelize;
db.sequelize = sequelize;

//Models/tables
db.customers = require('../model/customer.model.js')(sequelize, Sequelize);

DataTypes.DATE.prototype._stringify = function _stringify(date, options) {
  date = this._applyTimezone(date, options)
  return date.format('YYYY-MM-DD HH:mm:ss.SSS')
}

module.exports = db;