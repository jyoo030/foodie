const mongoose = require('mongoose');

const Group = require("../models/group");

const UserSchema = mongoose.Schema({
	userName: {
		type: String,
		caseSensitive: false,
		required: true
	},
	email: {
		type: String,
		caseSensitive: false,
		required: true
	},
	password: {
		type: String,
		required: true
	},
	firstName: {
		type: String,
		required: true
	},
	lastName: {
		type: String,
		required: true
	},
	friends: [{
		type: mongoose.Schema.Types.ObjectId, 
		ref: 'User'
	}],
	isDeleted: {
		type: Boolean,
		default: false
	},
	groups: [{ 
		type: mongoose.Schema.Types.ObjectId, 
		ref: 'Group'
	}],
	currentGroup: {
		type: mongoose.Schema.Types.ObjectId, 
		ref: 'Group'
	}
});

module.exports = mongoose.model('User', UserSchema);
