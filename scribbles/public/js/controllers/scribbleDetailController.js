app.controller('scribbleDetailController', 
	['$scope', '$routeParams', '$http', 'Scribbles', function ($scope, $routeParams, $http, Scribbles) {
	$scope.loading = true;
  Scribbles.getScribble($routeParams.id)
	.success(function(data) {
		$scope.loading = false;
		$scope.scribble = data;
	});
}]);