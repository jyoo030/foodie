const mongoose = require('mongoose');

const User = require("../models/user");

const GroupSchema = mongoose.Schema({
	name: {
		type: String,
		required: true
	},
	users: [{
		type: mongoose.Schema.Types.ObjectId,
		ref:'User',
		required: true
	}],
	likes: {
		type: Map,
		of: {type: Array, of: {type: String}},
		default: {}
	}
});

module.exports = mongoose.model('Group', GroupSchema);
