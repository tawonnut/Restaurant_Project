function printTest() {
    // open print dialog
    $('#print').dialog('open');

    //
    // build print data
    //

    // create print data builder object
    var builder = new epson.ePOSBuilder();

    builder.addText('Test Print\n');
    builder.addFeedLine(1);

    // append paper cutting
    builder.addCut();

    //
    // send print data
    //

    // create print object
    // var url = 'http://192.168.0.26/cgi-bin/epos/service.cgi?devid=local_printer&timeout=6000';
    // var epos = new epson.ePOSPrint(url);
	var epos = new epson.ePOSPrint();
	epos.address = 'http://192.168.0.26/cgi-bin/epos/services.cgi?devid=local_printer&timeout=6000';
    // register callback function
    epos.onreceive = function (res) {
        // close print dialog
        $('#print').dialog('close');
        // print failure
        if (!res.success) {
            // show error message
            $('#receive').dialog('open');
        }
    }

    // register callback function
    epos.onerror = function (err) {
        // close print dialog
        $('#print').dialog('close');
        // show error message
        $('#error').dialog('open');
    }

    // send
    epos.send(builder.toString());

}