const Nexmo = require('nexmo');

const API_KEY = '9bf56193';
const API_SECRET = 'fzTeZFuLiEX9VHmI';
//const APP_ID = '';
//const PRIVATE_KEY_PATH = '';

const nexmo = new Nexmo({
    apiKey: API_KEY,
    apiSecret: API_SECRET
});

module.exports = nexmo;