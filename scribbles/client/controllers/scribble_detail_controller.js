app.controller('ScribbleDetailController', 
	['$scope', '$routeParams', 'ScribbleList', function ($scope, $routeParams, ScribbleList) {
  $scope.scribble = ScribbleList[$routeParams.id];
}]);