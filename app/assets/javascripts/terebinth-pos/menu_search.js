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

  $scope.init = function() {
   $scope.dish.selected = JSON.parse($("#dish_json").val());
    // Init as empty arrays, need to change later to get real coordinates from DB
  console.log($scope.dish.selected)
  };
  $scope.init();  

    $scope.menu_dish = function() {
      console.log
    var create_params = {
      menu :          $scope.dish.selected.dish_name,
      menu_price :     $scope.dish.selected.dish_price,
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
          $( "#show_dish").load("#show_dish1 #show_dish")
      }
    })
    .error(function(data){
      $scope.eeror = status;
      console.log(create_params);
    });   

  };

}
listingCtrl.$inject = ['$scope','$http'];
App.controller('ListingController',listingCtrl);


listingCtrl = function($scope, $http){
  $scope.dessert = { selected:{} };
  $scope.menu = {};
  $scope.menu.value = 1
  $scope.menu.table_id = JSON.parse($("#table_id").val());

  $scope.refreshAddresses = function(dessert) {
  var dessert_name = {dessert_name: dessert};
    return $http.get(
      "/desserts/dessert_search",
      {params: dessert_name }
    ).then(function(response) {
      $scope.desserts = response.data;
    }); 
  }; 
  $scope.init = function() {
   $scope.dessert.selected = JSON.parse($("#dessert_json").val());
    // Init as empty arrays, need to change later to get real coordinates from DB
  console.log($scope.dessert.selected)
  };
  $scope.init();  

    $scope.menu_dessert = function() {
    var create_params = {
      menu :          $scope.dessert.selected.dessert_name,
      menu_price :    $scope.dessert.selected.dessert_price,
      remark :        $scope.menu.remark,
      value :         $scope.menu.value,
      menu_type :     "อาหารหวาน",
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
    $( "#show_dessert").load("#show_dessert1 #show_dessert")
      }
    })
    .error(function(data){
      $scope.eeror = status;
      console.log(create_params);
    });   

  }; 
  
}
listingCtrl.$inject = ['$scope','$http'];

App.controller('ListingController1',listingCtrl);

listingCtrl = function($scope, $http){
  $scope.drinking = { selected:{} };
  $scope.menu = {};
  $scope.menu.value = 1
  $scope.menu.table_id = JSON.parse($("#table_id").val());

  $scope.refreshAddresses = function(drinking) {
  var drinking_name = {drinking_name: drinking};
    return $http.get(
      "/drinkings/drink_search",
      {params: drinking_name }
    ).then(function(response) {
      $scope.drinkings = response.data;
    }); 
  }; 
    $scope.init = function() {
   $scope.drinking.selected = JSON.parse($("#drinking_json").val());
    // Init as empty arrays, need to change later to get real coordinates from DB
  console.log($scope.drinking.selected)
  };
  $scope.init();  
    $scope.menu_drinking = function() {

    var create_params = {
      menu :          $scope.drinking.selected.drinking_name,
      menu_price :    $scope.drinking.selected.drinking_price,
      remark :        $scope.menu.remark,
      value :         $scope.menu.value,
      menu_type :     "เครื่องดื่ม",
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
    $( "#show_drink").load("#show_drink1 #show_drink")
      }
    })
    .error(function(data){
      $scope.eeror = status;
      console.log("เวลเกินว่ะ บราย_!!!!!!!");
      console.log(create_params);
    });   

  }; 
  
}
listingCtrl.$inject = ['$scope','$http'];

App.controller('ListingController2',listingCtrl);