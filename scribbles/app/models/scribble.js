var mongoose = require('mongoose');
module.exports = mongoose.model('Scribble', {
	title : {type : String, default: ''},
	done: Boolean,
	description : {type : String, default: ''},
	updated_at: { type: Date, default: Date.now }
});