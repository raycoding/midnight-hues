app.controller('ScribbleListController', 
	['$scope', 'ScribbleList', function ($scope, ScribbleList) {
  $scope.scribblelist = ScribbleList;
}]);