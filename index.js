const express = require('express'); // Micro-framework for web
const app = express(); // use express module
const bodyParser = require('body-parser');
const config = require('./env/main.config');

// plugin
app.use(bodyParser.urlencoded({ extended: false }));

// Routers
app.use('/', require('./routers/index'));
app.use('/users', require('./routers/users'));
app.use('/auth', require('./routers/auth'));

app.listen(config.PORT, config.HOST, () => {
    let t = 0; // time iteration initialization
    let updateTime = 1000; // 1 / 1000 = 1 second

    // create logging
    return setInterval(() => {
        t++; // time clocking

        logging(t);
    }, updateTime);
});

const logging = (time) => {
    console.clear(); // clear console
    console.log(`Web Service Running on\t: http://${ config.HOST }:${ config.PORT }/`);
    console.log(`Web Service Uptime\t: ${ Math.floor((time / 3600)) } Hour ${ Math.floor((time % 3600) / 60) } Minute ${ time % 60 } Second`);
    console.log(`================================================================================`);
};

module.exports = app;