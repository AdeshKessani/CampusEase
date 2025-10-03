const dbConfig = {
  host: process.env.CAMPUSEASE_DB_HOST || 'localhost',
  user: process.env.CAMPUSEASE_DB_USER || 'root',
  password: process.env.CAMPUSEASE_DB_PASSWORD || 'ExpenseApp1',
  database: process.env.CAMPUSEASE_DB_NAME || 'transactions',
  port: process.env.CAMPUSEASE_DB_PORT || 3306,
};

module.exports = dbConfig;
