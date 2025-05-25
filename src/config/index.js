require('dotenv').config();

module.exports = {
  port: process.env.PORT || 8000,
  jwtSecret: process.env.JWT_SECRET,
  db: {
    host: process.env.DB_HOST,
    port: process.env.DB_PORT, 
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME,
    waitForConnections: true,
    connectionLimit: 10,
    charset: 'utf8mb4',  
  },
};