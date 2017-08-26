// load the things we need
var mongoose = require('mongoose');
var Schema = mongoose.Schema;

var imagesSchema = mongoose.Schema({
    created: {
	type: Date,
	default: Date.now
    },
    title: {
	type: String,
	default: '',
	trim: true,
	required: 'Title connot be blank'
    },
    imageName: {
	type: String
    },
    user: {
	type: Schema.ObjectId,
	ref: 'User'
    }
});

module.exports = mongoose.model('Images', imagesSchema);
