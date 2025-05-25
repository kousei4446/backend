const { Pool } = require('pg');
const { db } = require('./index');

module.exports = new Pool(db);  
