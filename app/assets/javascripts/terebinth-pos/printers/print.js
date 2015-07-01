
print = function($scope){

  $scope.print_menu= function(){

  console.log("askdjfhsakdhfksjhdfs")
  var canvas = document.getElementById('canvas');

var address = 'http://192.168.0.26./cgi-bin/epos/service.cgi?devid=local_printer&timeout=60000';

var builder = new epson.ePOSBuilder();
builder.addTextAlign(builder.ALIGN_CENTER);
builder.addText('Restaurant\n เวลา:16.16น.\n โต๊ะ:1\n ชื่อเมนู  รายละเอียด จำนวน\n ข้าวมันไก่ ไม่เอาไก่ 2');
builder.addFeedLine(3);
builder.addCut(builder.CUT_FEED);

var epos = new epson.ePOSPrint(address);
epos.onreceive = function (res) { alert(res.success); };
epos.onerror = function (err) { alert(err.status); };
epos.oncoveropen = function () { alert('coveropen'); };
epos.send(builder.toString());
  }
  

};

App.controller('Print', print);