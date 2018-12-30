const router = require('express').Router();
const connection = require('../env/db.config');

router.get('/', (req, res) => {
    return connection.query(
        'SELECT * FROM `users` WHERE phone_number = "6282120402431"',
        (err, results, fields) => res.json({
            message: 'success',
            status: res.statusCode,
            data: results
        })
    );
})

module.exports = router;