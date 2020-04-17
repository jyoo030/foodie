const express = require('express');
const router = express.Router();

// Group Model
const Group = require("../models/group");
const User = require("../models/user");

router.post('/create', (req, res) => {
	const {name, users, admins, location, radius} = req.body || {}
	if (!name || !users || !admins) {
		return res.status(400).json({msg: "Missing group name or list of users"})
	}

	if (admins.length == 0) {
		return res.status(400).json({msg: "Must appoint an admin"})
	}

	var newGroup = Group({
		name,
		users,
		admins
	})

	if (location && radius) {
		newGroup.location = location
		newGroup.radius = radius
	}

	newGroup.save().then(group => {
		// Update User's current groups
		for (var i = 0; i < users.length; i++) {
			User.findByIdAndUpdate(users[i], { "$push": { "groups": group.id }, "$set": { "currentGroup": group }}, {new: true},
				(err, raw) => {
					if (err) throw err;
				}
			);
		}
		return res.status(200).json({groupId: group.id, msg: "New Group created"});
	})
		.catch(err => console.log(err));
})

router.post('/remove', (req, res) => {
	const {groupId} = req.body || {}
	if (!groupId) {
		return res.status(400).json({msg: "Missing group"})
	}

	Group.findById(groupId).then(group => {
		if(!group) return res.status(400).json({msg: "No group by the id: " + groupId})
		users = User.find({groups: groupId})

		User.updateMany(users, {"$pull": {"groups": groupId}}, (err, raw) => {
			if (err) throw err
		})
	})

	Group.findByIdAndDelete(groupI, (err, raw) => {
		if (err) throw err;
	})
	return res.status(200).json({msg: "Group Removed"})

})

router.post('/user/add', (req, res) => {
	const {groupId, userId} = req.body || {}
	if (!groupId || !userId) {
		return res.status(400).json({msg: "Missing fields"});
	}

	Group.findById(groupId).then(group => {
		if(!group) return res.status(400).json({msg: "No group by the id: " + groupId})

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

router.post('/user/remove', (req, res) => {
	const {groupId, userId} = req.body || {}
	if (!groupId || !userId) {
		return res.status(400).json({msg: "Missing fields"});
	}

	Group.findById(groupId).then(group => {
		if(!group) return res.status(400).json({msg: "No group by the id: " + groupId})

		if(group.users.includes(userId)) {
			group.updateOne({ "$pull": {"users": userId} }, {new: true}, (err, raw) => {
				if (err) throw err;
			})

			User.findByIdAndUpdate(userId, { "$pull": {"groups": groupId} }, {new: true},(err, raw) => {
					if (err) throw err;
				}
			);
		}
		else {
			return res.status(400).json({msg: "User is not in this group!"})
		}
		return res.status(200).json({msg: "User Removed"})
	})
})

router.get('/id/:id', (req, res) => {
	const id = req.params.id;
	Group.findById(id).then(group => {
		if(!group) return res.status(400).json({msg: "No group by the id: " + id})

		res.status(200).json(group);
	})
})

module.exports = router;

