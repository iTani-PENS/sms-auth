const router = require('express').Router();
const nexmo = require('../env/nexmo.config');
const connection = require('../env/db.config');
const statusCode = require('../constant/status-code.constant');

router.get('/test', (req, res) => {
    const SENDER = 'ITANI';
    const RECIPIENT = '6282120402431';
    const CONTENT = `KODE VERIFIKASI: ${ new Date().getTime().toString().substr(-6) }`;

    nexmo.message.sendSms(SENDER, RECIPIENT, CONTENT);

    return res.json({
        message: 'SMS Sent',
        status: statusCode.OK
    });
});

router.get('/login/:phoneNumber', (req, res) => {
    let phone_number = req.params.phoneNumber;

    connection.query(
        "SELECT * FROM bumdes b, bumdes_verify bv WHERE b.nomor_telpon='" + phone_number + "' AND bv.id_bumdes=b.id AND bv.status='verified'",
        (err, results, fields) => {
            if (results.length > 0) {
                return res.json({
                    message: 'success',
                    status: statusCode.OK,
                    data: results[0]
                });

                // let { id } = results[0];

            } else {
                return res.json({
                    message: 'user not found or unverified',
                    status: statusCode.NO_CONTENT
                });
            }
        }
    )
});

module.exports = router;