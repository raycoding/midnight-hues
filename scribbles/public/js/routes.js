// Angular Routes
app
.config(['$routeProvider', '$locationProvider', function ($routeProvider,$locationProvider) {
  $routeProvider
    .when('/scribbles/:id', {
      templateUrl: 'templates/scribble_details.ejs',
      controller: 'scribbleDetailController'
   })
   .otherwise({redirectTo:'/'});
}]);