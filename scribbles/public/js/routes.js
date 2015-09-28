// Angular Routes
app.config(['$routeProvider', function ($routeProvider) {
  $routeProvider
    .when('/:id', {
      templateUrl: '/scribble_detail.html',
      controller: 'scribbleDetailController'
   });
}]);