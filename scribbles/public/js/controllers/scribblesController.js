app
	.controller('scribblesController', ['$scope', '$routeParams', '$http', 'Scribbles', function($scope, $routeParams, $http, Scribbles) {
		$scope.formData = {};
		$scope.loading = true;
		

		Scribbles.get()
			.success(function(data) {
				$scope.scribbles = data;
				$scope.loading = false;
			});

		//Creating new Scribble
		$scope.newScribble = function() {
			if ($scope.formData.text != undefined) {
				$scope.loading = true;
				Scribbles.create($scope.formData)
					.success(function(data) {
						$scope.loading = false;
						$scope.formData = {};
						$scope.scribbles = data;
					});
			}
		};

		//Marks a Scribble as completed
		$scope.completeScribble = function(id,state) {
			$scope.loading = true;
			obj = {'id':id,'state':state}
			Scribbles.complete(obj)
				.success(function(data) {
					$scope.loading = false;
					$scope.scribbles = data;
				});
		};

		//Delete a Scribble
		$scope.deleteScribble = function(id) {
			$scope.loading = true;
			Scribbles.delete(id)
				.success(function(data) {
					$scope.loading = false;
					$scope.scribbles = data;
				});
		};
	}]);