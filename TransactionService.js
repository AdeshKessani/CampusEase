const dbcreds = require('./DbConfig');
const mysql = require('mysql2'); // Using mysql2 driver

const con = mysql.createConnection({
    host: process.env.CAMPUSEASE_DB_HOST || dbcreds.DB_HOST,
    user: process.env.CAMPUSEASE_DB_USER || dbcreds.DB_USER,
    password: process.env.CAMPUSEASE_DB_PASSWORD || dbcreds.DB_PWD,
    database: process.env.CAMPUSEASE_DB_NAME || dbcreds.DB_DATABASE
});

function addTransaction(amount, desc) {
    const sql = `INSERT INTO transactions (amount, description) VALUES (?, ?)`;
    con.query(sql, [amount, desc], function (err, result) {
        if (err) throw err;
    });
    return 200;
}

function getAllTransactions(callback) {
    const sql = "SELECT * FROM transactions";
    con.query(sql, function (err, result) {
        if (err) throw err;
        return callback(result);
    });
}

function findTransactionById(id, callback) {
    const sql = "SELECT * FROM transactions WHERE id = ?";
    con.query(sql, [id], function (err, result) {
        if (err) throw err;
        return callback(result);
    });
}

function deleteAllTransactions(callback) {
    const sql = "DELETE FROM transactions";
    con.query(sql, function (err, result) {
        if (err) throw err;
        return callback(result);
    });
}

function deleteTransactionById(id, callback) {
    const sql = "DELETE FROM transactions WHERE id = ?";
    con.query(sql, [id], function (err, result) {
        if (err) throw err;
        return callback(result);
    });
}

module.exports = {
    addTransaction,
    getAllTransactions,
    findTransactionById,
    deleteAllTransactions,
    deleteTransactionById
};
