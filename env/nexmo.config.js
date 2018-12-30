const Nexmo = require('nexmo');

const API_KEY = '923bb324';
const API_SECRET = 'Pa4xAC7JKMWvV4Hs';
//const APP_ID = '';
//const PRIVATE_KEY_PATH = '';

const nexmo = new Nexmo({
    apiKey: API_KEY,
    apiSecret: API_SECRET
});

module.exports = nexmo;