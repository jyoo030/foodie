const mongoose = require('mongoose');

const GroupSchema = mongoose.Schema({
	users: {
		type: Array,
		default: [String]
	},
	likes: {
		type: Map,
		of: {type: Array, of: {type: String}},
		default: {}
	}
});

module.exports = mongoose.model('Group', GroupSchema);
