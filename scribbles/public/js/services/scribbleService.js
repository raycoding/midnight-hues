app
	.factory('Scribbles', ['$http',function($http) {
		return {
			get : function() {
				return $http.get('/api/scribbles');
			},
			create : function(data) {
				return $http.post('/api/scribbles', data);
			},
			delete : function(id) {
				return $http.delete('/api/scribbles/' + id);
			},
			complete : function(data) {
				return $http.post('/api/scribbles/complete/',data);
			}
		}
	}]);