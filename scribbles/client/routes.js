// Routes
app.config(['$routeProvider', function ($routeProvider) {
  $routeProvider
    .when('/', {
      templateUrl: '/scribble_list.html',
      controller: 'ScribbleListController'
    })
    .when('/:id', {
      templateUrl: '/scribble_detail.html',
      controller: 'ScribbleDetailController'
   });
}]);