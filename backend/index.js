"use strict";

var util = require("util");

require("dotenv").config();

const express = require("express");
const bodyParser = require("body-parser");
const port = 3000;
const mongoose = require("mongoose");
const http = require('http');
const socketio = require('socket.io');

var currentSockets = {}
const Notification = require("./models/notification");

mongoose
    .connect(
        process.env.DB_CONNECTION_STRING,
        { useNewUrlParser: true, useUnifiedTopology: true, useFindAndModify: false },
        () => console.log("connected to DB!")
    )
    .catch(err => console.log(err));

const app = express();

const server = http.createServer(app);
const io = socketio(server);

app.use(bodyParser.json());
// Routes
app.use('/restaurant', require('./routes/restaurant'));
app.use('/user', require('./routes/user'));
app.use('/group', require('./routes/group'));
app.use('/notification', require('./routes/notification'));

io.on('connect', socket => {
	console.log('new connection');

    socket.on("user_online", (data) => {
        const {userId, socketId} = data 
        currentSockets[userId] = socketId;
        console.log(JSON.stringify(currentSockets))
    });

    socket.on("disconnect", () => {
        let key = Object.keys(currentSockets).find(key => currentSockets[key] === socket.id);
        delete currentSockets[key]
        console.log(JSON.stringify(currentSockets))
    })

    socket.on("friend_request", (data) => {
        console.log("friend_request")

        // Check user is online
        if (Object.keys(io.sockets.sockets).includes(data.to)) {
            io.to(currentSockets[data.to]).emit('friend_request')
        }

        // Send Push Notification
        // Store in NotificationSchema

        var newNotification = Notification({
            "sender": data.from,
            "reciever": data.to,
            "message": "friend_request"
        })

        newNotification.save();
    })
});

server.listen(port, () => console.log(`foodieAPI listening on port ${port}!`));
