const router = require('express').Router();
const nexmo = require('../env/nexmo.config');
const connection = require('../env/db.config');
const statusCode = require('../constant/status-code.constant');

router.get('/login/:phoneNumber', (req, res) => {
    let DATE = new Date();
    let CODE = DATE.getTime().toString().substr(-6);
    let SENDER = 'ITANI';
    let CONTENT = `KODE VERIFIKASI: ${ CODE }`;

    let phone_number = req.params.phoneNumber;

    connection.query(
        "SELECT b.id, b.nama, b.nomor_telpon FROM bumdes b, bumdes_verify bv WHERE b.nomor_telpon='" + phone_number + "' AND bv.id_bumdes=b.id AND bv.status='verified'",
        (err, results, fields) => {
            if (results.length > 0) {
                let bumdes_id = results[0].id;
                let bumdes_phone = results[0].nomor_telpon;

                connection.query(
                    "REPLACE INTO bumdes_session (id_bumdes, nomor_telpon, code, date) VALUES ("+ bumdes_id +", '"+ bumdes_phone +"','"+ CODE +"', NOW())",
                    (errSession, resultSession, fields) => {
                        // nexmo.message.sendSms(SENDER, phone_number, CONTENT);
                
                        return res.json({
                            message: 'success',
                            status: statusCode.OK,
                            data: {
                                verification_code: CODE,
                                profile: results[0]
                            }
                        });
                    }
                );
            } else {
                return res.json({
                    message: 'user not found or unverified',
                    status: statusCode.NO_CONTENT
                });
            }
        }
    );
});

router.get('/check/:phoneNumber/:code', (req, res) => {
    let phone_number = req.params.phoneNumber;
    let code = req.params.code;

    connection.query(
        "SELECT * FROM bumdes_session WHERE nomor_telpon='"+phone_number+"' AND code='"+code+"'",
        (err, results, fields) => {
            if (results.length > 0) {
                return res.json({
                    message: 'is logged in',
                    status: statusCode.ACCEPTED,
                });
            } else {
                return res.json({
                    message: 'not login',
                    status: statusCode.UNAUTHORIZED,
                });
            }
        }
    )
});

router.post('/register', (req, res) => {
    res.json(req.body);
});

module.exports = router;