listingCtrl = function($scope, $http){
  $scope.dish = { selected:{} };
  $scope.menu = {};
  $scope.menu.value = 1
  $scope.menu.table_id = JSON.parse($("#table_id").val());

  $scope.refreshAddresses = function(dish) {
  var dish_name = {dish_name: dish};
    return $http.get(
      "/dishs/dish_search",
      {params: dish_name }
    ).then(function(response) {
      $scope.dishs = response.data;
    }); 
  }; 

    $scope.menu_dish = function() {
      console.log
    var create_params = {
      menu :          $scope.dish.selected.dish_name,
      remark :        $scope.menu.remark,
      value :         $scope.menu.value,
      menu_type :     "อาหารคาว",
      table_id :      $scope.menu.table_id.$oid
    }; 
    console.log(create_params)

     $http.post('/menu_lists.json',create_params)
    .success(function(data){
      var property = JSON.stringify(data).substring(1, 8);
      if (property === '"error"'){
      toastr.warning("ยังไม่เลือกรายการอาหาร");    

      }
      else {
        toastr.success("เพิ่มอาหารเรียบร้อย");
         $scope.menu.remark =""
    //      $.ajax({
    // url: "/menu_lists/"+$scope.menu.table_id.$oid,
    // cache: false,
    // success: function(html){
    //   $("#test").loat(html);
    // }
    // }); 
    $( "#show_data").load("#show_data1 table")
      }
    })
    .error(function(data){
      $scope.eeror = status;
      console.log("เวลเกินว่ะ บราย_!!!!!!!");
      console.log(create_params);
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