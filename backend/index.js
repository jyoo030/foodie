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
const User = require("./models/user");

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

    socket.on("friend_request", async (data, ackFn) => {
        console.log("friend_request")

        // Send Push Notification
        // Store in NotificationSchema


        var newNotification = Notification({
            "sender": data.from,
            "reciever": data.to,
            "message": "friend_request"
        })

        let notification = await newNotification.save();
        await notification
            .populate({
                path: 'sender', 
                select: '-groups -password -currentGroup',
                populate: { 
                    path: 'friends',
                    select: '-groups -password -currentGroup'}
            })
            .populate({
                path: 'reciever', 
                select: '-groups -password -currentGroup',
                populate: { 
                    path: 'friends',
                    select: '-groups -password -currentGroup'}
            })
            .execPopulate();

        // Check user is online
        if (Object.keys(currentSockets).includes(data.to)) {
            // Send notification to reciever
            io.to(currentSockets[data.to]).emit('friend_request', notification)
        }

        // Send notification to Sender
        ackFn(notification);
    })

    // pass in id of notification
    // pass in accept: Bool
    socket.on("friend_request_response", async (data, ackFn) => {
        let notification =  await Notification.findById(data.id)
            .populate({
                path: 'sender', 
                select: '-groups -password -currentGroup',
                populate: { 
                    path: 'friends',
                    select: '-groups -password -currentGroup'}
            })
            .populate({
                path: 'reciever', 
                select: '-groups -password -currentGroup',
                populate: { 
                    path: 'friends',
                    select: '-groups -password -currentGroup'}
            });

        let senderId = String(notification.sender.id)

        if (data.accept) {
            let user = await User.findById(senderId)

            await user.updateOne({ "$push": {"friends": notification.reciever } }, {new: true});

            await User.findByIdAndUpdate(notification.reciever.id, { "$push": {"friends": notification.sender} }, {new: true});	
        }

        // delete notification
        await Notification.findByIdAndRemove(notification.id);

        // Check user is online
        if (Object.keys(currentSockets).includes(senderId)) {
            io.to(currentSockets[senderId]).emit('friend_request_response', notification, data.accept)
        }

        ackFn(notification);
    });

     socket.on("cancel_friend_request", async (data, ackFn) => {
        let notification =  await Notification.findById(data.id)
            .populate({
                path: 'sender', 
                select: '-groups -password -currentGroup',
                populate: { 
                    path: 'friends',
                    select: '-groups -friends -password -currentGroup'}
            })
            .populate({
                path: 'reciever', 
                select: '-groups -password -currentGroup',
                populate: { 
                    path: 'friends',
                    select: '-groups -friends -password -currentGroup'}
            });

        var recieverId = String(notification.reciever)

        // delete notification
        await Notification.findByIdAndRemove(notification.id);

        if (Object.keys(currentSockets).includes(recieverId)) {
            io.to(currentSockets[recieverId]).emit('cancel_friend_request', notification)
        }

        ackFn(notification);
    });

    socket.on("delete_friend", async(data, ackFn) => {
        let currentUserId = data.currentUserId
        let friendId = data.friendId

        await User.findByIdAndUpdate(currentUserId, { "$pull": {"friends": friendId} });	
        await User.findByIdAndUpdate(friendId, { "$pull": {"friends": currentUserId} });	


        if (Object.keys(currentSockets).includes(friendId)) {
            io.to(currentSockets[friendId]).emit('delete_friend', currentUserId);
        }

        ackFn();
    });

});

server.listen(port, () => console.log(`foodieAPI listening on port ${port}!`));
