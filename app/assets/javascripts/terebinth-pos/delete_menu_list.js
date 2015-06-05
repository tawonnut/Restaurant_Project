
delete_menu = function($scope,$http){
  $scope.delete= function(menu_id){
    $http({url:"/menu_lists/"+menu_id
      ,method:"DELETE"
    }).
    success(function(data){
      toastr.success("ลบเมนูอาหารเรียบร้อย");
      // $( "#show_drink").load("#show_drink1 #show_drink")
       $( "#show_dish").load("#show_dish1 #show_dish")
      // $( "#show_dessert").load("#show_dessert1 #show_drink")
    }).
    error(function(data){
      $scope.eeror = status;
      console.log("บึ้ม บึ้ม บึ้ม บึ้ม บึ้ม");

    });
  }

};

delete_menu.$inject = ['$scope','$http'];
App.controller('Delete_menu', delete_menu);


App.directive('ngConfirmClick', [
    function(){
        return {
            priority: 1,
            terminal: true,
            link: function (scope, element, attr) {
                var msg = attr.ngConfirmClick || "ยืนยันการลบ";
                var clickAction = attr.ngClick;
                element.bind('click',function (event) {
                    if ( window.confirm(msg) ) {
                        scope.$eval(clickAction)
                    }
                });
            }
        };
}])
