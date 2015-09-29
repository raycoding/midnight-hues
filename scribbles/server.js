// Server Configuration
var express  = require('express');
var app      = express();
var port  	 = process.env.PORT || 8080;

// DB variables & connection
var mongoose = require('mongoose');
var database = require('./config/database');
mongoose.connect(database.url);

var morgan   = require('morgan');
var bodyParser = require('body-parser');
var methodOverride = require('method-override');

// Standards taken from practices
app.set('views', __dirname + '/views');
app.set('view engine', 'ejs');
app.use(express.static(__dirname + '/public'));
app.use(morgan('dev')); // log every request to the console
app.use(bodyParser.urlencoded({'extended':'true'})); // parse application/x-www-form-urlencoded
app.use(bodyParser.json()); // parse application/json
app.use(bodyParser.json({ type: 'application/vnd.api+json' })); // parse application/vnd.api+json as json
app.use(methodOverride('X-HTTP-Method-Override')); // override with the X-HTTP-Method-Override header in the request

// routes ======================================================================
require('./app/routes.js')(app);

// Start the Server listening to port 
app.listen(port);
console.log("Scribbler App listening on port " + port);
