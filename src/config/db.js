const mysql = require('mysql2/promise');
const { db } = require('./index');

module.exports = mysql.createPool(db);
