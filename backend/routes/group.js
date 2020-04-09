const express = require('express');
const router = express.Router();

// Group Model
const Group = require("../models/group");
const User = require("../models/user");

router.post('/create', (req, res) => {
	const {name, users} = req.body || {}
	if (!name || !users) {
		return res.status(400).json({msg: "Missing group name or list of users"})
	}

	const newGroup = Group({
		name,
		users
	})

	newGroup.save().then(group => {
		// Update User's current groups
		for (var i = 0; i < users.length; i++) {
			User.findByIdAndUpdate(users[i], { "$push": { "groups": group.id } }, {new: true},
				(err, raw) => {
					if (err) throw err;
				}
			);
		}
		return res.status(200).json({msg: "New Group created"});
	})
		.catch(err => console.log(err));
})

router.post('/user/add', (req, res) => {
	const {groupId, userId} = req.body || {}
	if (!groupId || !userId) {
		return res.status(400).json({msg: "Missing fields"});
	}

	Group.findById(groupId).then(group => {
		if(group.users.includes(userId)) {
			return res.status(400).json({msg: "User already in the group"})
		}

		group.updateOne({ "$push": {"users": userId } }, {new: true}, (err, raw) => {
			if (err) throw err;
		})

		User.findByIdAndUpdate(userId, { "$push": {"groups": groupId } }, {new: true},
			(err, raw) => {
				if (err) throw err;
			}
		);

		return res.status(200).json({msg: "User added"});
	})
})

router.get('/id/:id', (req, res) => {
	const id = req.params.id;
	Group.findById(id).then(group => {
		if(!group) return rest.status(400).json({msg: "No group by the id: " + id})

		res.status(200).json(group);
	})
})

module.exports = router;

