// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require jquery.ui.all
//= require bootstrap-sprockets
//= require_tree .

//= require websocket_rails/main

$(function() { 
	// var task = {
	//   name: 'Start taking advantage of WebSockets',
	//   completed: false
	// }

	var dispatcher = new WebSocketRails(window.location.host + "/websocket")

	console.log(dispatcher)

	// dispatcher.trigger('tasks.create', task);

	dispatcher.bind('create_success', function() {
	  console.log('successfully created');
	});

	$("#send_message").click(function() {
	  dispatcher.trigger('create', "sent");
	});
});