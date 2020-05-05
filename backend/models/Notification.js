const mongoose = require('mongoose');

const NotificationSchema = mongoose.Schema({
    sender: {
		type: mongoose.Schema.Types.ObjectId,
		ref:'User',
		required: true
    },
    reciever: {
        type: String,
        required: true
    },
    message: {
        type: String,
        required: true
    }
});

module.exports = mongoose.model('Notification', NotificationSchema);
