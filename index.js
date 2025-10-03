const transactionService = require('./TransactionService');
const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');
const moment = require('moment');

const app = express();
const port = 8080;

app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());
app.use(cors());

// Health Check
app.get('/health', (req, res) => {
    res.json("This is the health check using CICD");
});

// Add Transaction
app.post('/transaction', (req, res) => {
    try {
        const t = moment().unix();
        console.log(`{ "timestamp" : ${t}, "msg" : "Adding Expense", "amount" : ${req.body.amount}, "description": "${req.body.desc}" }`);
        const success = transactionService.addTransaction(req.body.amount, req.body.desc);
        if (success === 200) res.json({ message: 'added transaction successfully' });
    } catch (err) {
        res.json({ message: 'something went wrong', error: err.message });
    }
});

// Get All Transactions
app.get('/transaction', (req, res) => {
    try {
        transactionService.getAllTransactions(results => {
            const transactionList = results.map(row => ({
                id: row.id,
                amount: row.amount,
                description: row.description
            }));
            const t = moment().unix();
            console.log(`{ "timestamp" : ${t}, "msg" : "Getting All Expenses" }`);
            console.log(`{ "expenses" : ${JSON.stringify(transactionList)} }`);
            res.status(200).json({ result: transactionList });
        });
    } catch (err) {
        res.json({ message: "could not get all transactions", error: err.message });
    }
});

// Delete All Transactions
app.delete('/transaction', (req, res) => {
    try {
        transactionService.deleteAllTransactions(result => {
            const t = moment().unix();
            console.log(`{ "timestamp" : ${t}, "msg" : "Deleted All Expenses" }`);
            res.status(200).json({ message: "delete function execution finished." });
        });
    } catch (err) {
        res.json({ message: "Deleting all transactions may have failed.", error: err.message });
    }
});

// Delete One Transaction
app.delete('/transaction/id', (req, res) => {
    try {
        transactionService.deleteTransactionById(req.body.id, result => {
            res.status(200).json({ message: `transaction with id ${req.body.id} seemingly deleted` });
        });
    } catch (err) {
        res.json({ message: "error deleting transaction", error: err.message });
    }
});

// Get Single Transaction
app.get('/transaction/id', (req, res) => {
    try {
        transactionService.findTransactionById(req.body.id, result => {
            if (result.length > 0) {
                const { id, amount, description } = result[0];
                res.json({ id, amount, description });
            } else {
                res.json({ message: "transaction not found" });
            }
        });
    } catch (err) {
        res.json({ message: "error retrieving transaction", error: err.message });
    }
});

app.listen(port, () => {
    const t = moment().unix();
    console.log(`{ "timestamp" : ${t}, "msg" : "App Started on Port ${port}" }`);
});
