// var canvas = document.getElementById('canvas');
// var context = canvas.getContext('2d');
// var address = 'http://192.168.0.26./cgi-bin/epos/service.cgi?devid=local_printer&timeout=60000';

// var builder = new epson.ePOSBuilder();
// builder.addTextAlign(builder.ALIGN_CENTER);
// builder.addText('Terebinth-Restaurant\n');
// builder.addFeedUnit(15);
// builder.addTextAlign(builder.ALIGN_CENTER);
// builder.addText('Restaurant\n โต๊ะที่:1\n รายการอาหาร รายละเอียด  จำนวน');
// builder.addFeedUnit(15);
// builder.addCut(builder.CUT_FEED);

// var epos = new epson.ePOSPrint(address);
// epos.onreceive = function (res) { alert(res.success); };
// epos.onerror = function (err) { alert(err.status); };
// epos.oncoveropen = function () { alert('coveropen'); };
// epos.send(builder.toString());