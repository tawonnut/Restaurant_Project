listingCtrl = function($scope, $http){
  $scope.dish = { selected:{} };

  $scope.refreshAddresses = function(dish) {
  var dish_name = {dish_name: dish};
    return $http.get(
      "/dishs/dish_search",
      {params: dish_name }
    ).then(function(response) {
      $scope.dishs = response.data;
    }); 
  }; 

  // $scope.init = function() {
  //  $scope.listing.selected = JSON.parse($("#listing_json").val());
  //   // Init as empty arrays, need to change later to get real coordinates from DB
  // };

  //  console.log($scope.listing.selected);
  // $scope.init();  

   
}
listingCtrl.$inject = ['$scope','$http'];

App.controller('ListingController',listingCtrl);