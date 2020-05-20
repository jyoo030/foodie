const express = require('express');
const router = express.Router();

// Models
const Notification = require("../models/notification");
const User = require("../models/user");

router.get('/id/:id', (req, res) => {
	const id = req.params.id;
    Notification.find({ $or:[ {'sender': id}, {'reciever': id} ] })
		.populate({
			path: 'sender', 
			select: '-groups -friends -password -currentGroup'})
		.populate({
			path: 'reciever', 
			select: '-groups -friends -password -currentGroup'})
        .then(notifications => {
        return res.status(200).json(notifications);
    })
})

router.post('/id/:id', async (req, res) => {
    const id = req.params.id;
    const response = req.query.response;

    let notification =  await Notification.findById(id);

    if (!notification) return res.status(400).json({errors: ["Could not find notification by the id: " + id]})

    if (notification.message == "friend_request") {
        if (response == "true") {
            let user = await User.findById(notification.sender)

            if (!user) return res.status(400).json({errors: ["No user by the id: " + notification.sender]})
            if (user.friends.includes(notification.reciever))
                return res.status(400).json({errors: ["User is already a friend"]})

            await user.updateOne({ "$push": {"friends": notification.reciever } }, {new: true});

            await User.findByIdAndUpdate(notification.reciever, { "$push": {"friends": notification.sender} }, {new: true});	
        }

        // delete notification
        await Notification.findByIdAndRemove(notification.id);
        return res.status(200).json({msg: "Friend Added"})
    }
});

module.exports = router;
