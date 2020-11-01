const env = {
  database: 'customer',
  username: 'sa',
  password: 'Sabbr@12345',
  host: 'bhaskar-db-service',
  dialect: 'mssql',
  dialectOptions: {
    ssl: {
      require: false,
      rejectUnauthorized: false 
    }
  },
  pool: {
	  max: 5,
	  min: 0,
	  acquire: 30000,
	  idle: 10000
  }
};

module.exports = env;