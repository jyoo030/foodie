const mongoose = require('mongoose');

const User = require("../models/user");

const GroupSchema = mongoose.Schema({
	admins: {
		type: Array,
		default: [String]
	},
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
	},
	location: {
		type: String,
		default: "Riverside, CA"
	},
	radius: {
		type: Number,
		default: 2000
	}
});

module.exports = mongoose.model('Group', GroupSchema);
