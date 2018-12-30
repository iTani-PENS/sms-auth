const router = require('express').Router();
const nexmo = require('../env/nexmo.config');

router.get('/test', (req, res) => {
    const SENDER = 'ITANI';
    const RECIPIENT = '6282120402431';
    const CONTENT = `KODE VERIFIKASI: ${ new Date().getTime().toString().substr(-6) }`;

    nexmo.message.sendSms(SENDER, RECIPIENT, CONTENT);

    return res.json({
        message: 'SMS Sent',
        status: res.statusCode
    });
});

module.exports = router;