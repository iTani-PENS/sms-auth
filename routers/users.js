const router = require('express').Router();
const connection = require('../env/db.config');

router.get('/', (req, res) => {
    return connection.query(
        'SELECT * FROM `users`',
        (err, results, fields) => res.json(results)
    );
})

module.exports = router;