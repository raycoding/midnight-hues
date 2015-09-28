var Scribble = require('./models/scribble');

function scribblesList(res){
	Scribble.find(function(err, scribbles) {
			if (err)
				res.send(err)
			res.json(scribbles); // return all scribbles
		}).sort({ done : 1 });
};

module.exports = function(app) {

	app.get('/api/scribbles', function(req, res) {
		scribblesList(res);
	});

	// create a scribble and return updated set
	app.post('/api/scribbles', function(req, res) {
		Scribble.create({
			title : req.body.text,
			done : false
		}, function(err, scribble) {
			if (err)
				res.send(err);
			scribblesList(res);
		});

	});

	// mark a scribble complete and return updated set
	app.post('/api/scribbles/complete', function(req, res) {
		Scribble.update({
			_id : req.body.id
		},
		{	$set : {done: req.body.state} },
		function(err, scribble) {
			if (err)
				res.send(err);
			scribblesList(res);
		});
	});

	// delete a scribble and return updated set
	app.delete('/api/scribbles/:scribble_id', function(req, res) {
		Scribble.remove({
			_id : req.params.scribble_id
		}, function(err, scribble) {
			if (err)
				res.send(err);
			scribblesList(res);
		});
	});

	// default -------------------------------------------------------------
	app.get('*', function(req, res) {
		res.sendfile('./public/index.html');
	});
};