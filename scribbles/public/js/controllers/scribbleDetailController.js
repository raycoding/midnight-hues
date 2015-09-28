app.controller('scribbleDetailController', 
	['$scope', '$routeParams', '$http', 'Scribbles', function ($scope, $routeParams, $http, Scribbles) {
  $scope.scribble = Scribbles[$routeParams.id];
}]);