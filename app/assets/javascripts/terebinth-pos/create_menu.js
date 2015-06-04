
createmenu = function($scope,$http, $rootScope){
	$scope.create_menu = function() {
    
    var create_params = {
      menu_area :        $scope.menu.area,
      menu_unit :        $scope.menu.unit,
    }; 

	   $http.post('/menu_lists.json',create_params)
    .success(function(data){
      var property = JSON.stringify(data).substring(1, 8);
      if (property === '"error"'){

        for (i = 0; i < data.error.length; i++) { 
          toastr.warning(data.error[i]);    
        }

      }
      else {
        toastr.success("เพิ่มโครงการเรียบร้อย"); 
        $scope.property.name='';
        $scope.property.area='';
        $scope.property.unit='';
      }
    })
    .error(function(data){
      $scope.eeror = status;
      console.log("เวลเกินว่ะ บราย_!!!!!!!");
      console.log(create_params);
    });   

  };


};

createmenu.$inject = ['$scope','$http','$rootScope'];

App.controller('createmenu', createmenu);
