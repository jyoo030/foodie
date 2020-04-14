const mongoose = require('mongoose');

const Group = require("../models/group");

const UserSchema = mongoose.Schema({
	email: {
		type: String,
		required: true
	},
	password: {
		type: String,
		required: true
	},
	name: {
		type: String,
		required: true
	},
	friends: [{
		type: mongoose.Schema.Types.ObjectId, 
		ref: 'User'
	}],
	groups: [{ 
		type: mongoose.Schema.Types.ObjectId, 
		ref: 'Group'
	}]
});

module.exports = mongoose.model('User', UserSchema);
