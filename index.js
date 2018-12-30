const express = require('express'); // Micro-framework for web
const app = express(); // use express module
const bodyParser = require('body-parser');

// plugin
app.use(bodyParser.json({}));

// Routers
app.use('/', require('./routers/index'));
app.use('/users', require('./routers/users'));

const HOST = '0.0.0.0'; // web service host
const PORT = 3000; // web service port

app.listen(PORT, HOST, () => {
    let t = 0; // time iteration initialization
    let updateTime = 1000; // 1 / 1000 = 1 second

    // create logging
    return setInterval(() => {
        t++; // time clocking

        console.clear(); // clear console
        console.log(`Web Service Running on\t: http://${ HOST }:${ PORT }/`);
        console.log(`Web Service Uptime\t: ${ Math.floor((t / 3600)) } Hour ${ Math.floor((t % 3600) / 60) } Minute ${ t % 60 } Second`);
        console.log(`================================================================================`);
    }, updateTime);
});

module.exports = app;