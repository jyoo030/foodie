const mongoose = require('mongoose');

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
	friends: {
		type: Array,
		default: [String]
	}
});

module.exports = mongoose.model('User', UserSchema);
