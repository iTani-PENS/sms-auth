const router = require('express').Router();

router.get('/', (req, res) => res.json({
    message: 'Welcome',
    status: res.statusCode
}));

module.exports = router;