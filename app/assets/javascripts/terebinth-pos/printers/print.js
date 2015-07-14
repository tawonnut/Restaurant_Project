//
// print queue ticket
//

function printTicket() {

    // open print dialog
    $('#print').dialog('open');

    //
    // build print data
    //

    // create print data builder object
    var builder = new epson.ePOSBuilder();

    // paper layout
    if (layout) {
        builder.addLayout(builder.LAYOUT_RECEIPT, 580);
    }

    // get current date
    var now = new Date();

    // ticket number
    var number = ('0000' + sequence).slice(-4);

    // initialize (ank mode, smoothing)
    builder.addTextLang('en').addTextSmooth(true);

    // draw image (for raster image)
    var canvas = $('#canvas').get(0);
    var context = canvas.getContext('2d');
    context.drawImage($('#logo').get(0), 0, 0, 200, 70);

    // append raster image
    builder.addTextAlign(builder.ALIGN_CENTER);
    builder.addImage(context, 0, 0, 200, 70);
    builder.addFeedLine(1);

    // append ticket number
    builder.addTextAlign(builder.ALIGN_LEFT);
    builder.addTextDouble(true, false).addText('Your Number:');
    builder.addTextDouble(false, false).addText('\n');
    builder.addFeedUnit(16);
    builder.addTextAlign(builder.ALIGN_CENTER);
    builder.addTextSize(6, 4).addText(number);
    builder.addTextSize(1, 1).addText('\n');
    builder.addFeedUnit(16);

    // append message
    builder.addTextStyle(false, false, true);
    builder.addText('Please wait until your ticket\n');
    builder.addText('number is called.\n');
    builder.addTextStyle(false, false, false);
    builder.addFeedUnit(16);

    // append date and time
    builder.addText(now.toDateString() + ' ' + now.toTimeString().slice(0, 8) + '\n');
    builder.addFeedUnit(16);

    // append barcode
    builder.addBarcode(number, builder.BARCODE_CODE39, builder.HRI_BELOW, builder.FONT_A, 2, 48);
    builder.addFeedLine(1);

    // append paper cutting
    builder.addCut();

    //
    // send print data
    //

    // create print object
    var url = 'http://' + ipaddr + '/cgi-bin/epos/service.cgi?devid=' + devid + '&timeout=' + timeout;
    var epos = new epson.ePOSPrint(url);

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

    // set next ticket number
    sequence = sequence % 9999 + 1;
}

//
// print coupon
//

function printCoupon() {

    // open print dialog
    $('#print').dialog('open');
    // to be continued
    setTimeout(printCoupon1, 500);
}

// print coupon
function printCoupon1() {

    //
    // draw print data
    //

    // get context of canvas
    var canvas = $('#canvas').get(0);
    var context = canvas.getContext('2d');

    // get current date
    var now = new Date();

    // draw background image
    context.clearRect(0, 0, 512, 480);
    context.drawImage($('#coffee').get(0), 0, 0, 512, 384);
    context.fillStyle = 'rgba(255, 255, 255, 0.5)';
    context.fillRect(0, 0, 512, 480);
    context.fillStyle = 'rgba(0, 0, 0, 1.0)';

    // draw water mark
    context.drawImage($('#wmark').get(0), 0, 0);
    context.drawImage($('#wmark').get(0), 256, 324);

    // draw serial number
    context.textAlign = 'end';
    context.textBaseline = 'top';
    context.font = 'normal normal normal 24px "Arial", sans-serif';
    context.fillText('No. ' + ('000000' + serial).slice(-6), 512, 0);

    // draw message with rotation
    context.translate(96, 112);
    context.rotate(-Math.PI / 12);
    context.textAlign = 'center';
    context.textBaseline = 'middle';
    context.font = 'italic normal normal 48px "Times New Roman", serif';
    context.fillText('Enjoy!', 0, 0);
    context.rotate(Math.PI / 12);
    context.translate(-96, -112);

    // draw title
    context.textAlign = 'center';
    context.textBaseline = 'alphabetic';
    context.font = 'normal normal bold 72px "Arial", sans-serif';
    context.fillText('FREE Coffee', 256, 224);
    context.font = 'normal normal bold 36px "Times New Roman", serif';
    context.fillText('Expires ' + now.toDateString(), 256, 288);

    // draw time
    context.textAlign = 'start';
    context.textBaseline = 'bottom';
    context.font = 'normal normal normal 24px "Arial", sans-serif';
    context.fillText(now.toTimeString().slice(0, 8), 0, 384);

    // draw barcode
    if (!grayscale) {
        drawEan13(context, '201234567890', 139, 400, 2, 80);
    }

    //
    // print
    //

    // create print object
    var url = 'http://' + ipaddr + '/cgi-bin/epos/service.cgi?devid=' + devid + '&timeout=' + timeout;
    var epos = new epson.CanvasPrint(url);

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

    // paper layout
    if (layout) {
        epos.paper = epos.PAPER_RECEIPT;
        epos.layout = { width: 580 };
    }

    // print
    if (grayscale) {
        epos.mode = epos.MODE_GRAY16;
    }
    else {
        epos.mode = epos.MODE_MONO;
        epos.halftone = epos.HALFTONE_ERROR_DIFFUSION;
    }
    epos.cut = true;
    epos.print(canvas);

    // set next serial number
    serial = serial % 999999 + 1;
}

//
// print label
//

function printLabel() {

    // open print dialog
    $('#print').dialog('open');

    //
    // build print data
    //

    // color list
    var color = ['Gold', 'Red', 'Yellow', 'Green', 'Blue', 'Purple', 'Brown', 'Black', 'White', 'Sliver'];

    // create print data builder object
    var builder = new epson.ePOSBuilder();
    with (builder) {

        // paper layout
        if (layout) {
            addLayout(LAYOUT_LABEL, 580, 0, 15, -15, 25, 0);
        }

        // initialize (alphanumeic mode, smoothing)
        addTextLang('en');
        addTextSmooth(1);

        // paper control
        addFeedPosition(FEED_CURRENT_TOF);

        // paper control for first print
        if (layout) {
            addFeedPosition(FEED_NEXT_TOF);
        }

        // start page mode
        addPageBegin();

        // format
        addPageArea(0, 0, 384, 160);

        // format - title
        addPagePosition(0, 21);
        addText('Name');
        addPagePosition(0, 71);
        addText('Color');
        addPagePosition(0, 121);
        addText('Code');

        // format - line
        addTextStyle(0, 1, 0);
        addPagePosition(0, 42);
        addText('                                ');
        addPagePosition(0, 92);
        addText('                                ');
        addTextStyle(0, 0, 0);

        // name
        addPageArea(100, 0, 284, 50);
        addPagePosition(0, 42);
        addTextDouble(0, 1);
        addText('Item A');

        // color
        addPageArea(100, 50, 284, 50);
        addPagePosition(0, 33);
        addTextDouble(0, 0);
        addText(color[code % 10]);

        // barcode
        addPageArea(100, 100, 284, 60);
        addPagePosition(0, 35);
        addBarcode(code, BARCODE_CODE39, HRI_BELOW, FONT_A, 2, 36);

        // end page mode
        addPageEnd();

        // paper control
        addFeedPosition(FEED_PEELING);
    }

    //
    // send print data
    //

    // create print object
    var url = 'http://' + ipaddr + '/cgi-bin/epos/service.cgi?devid=' + devid + '&timeout=' + timeout;
    var epos = new epson.ePOSPrint(url);

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

    // set next item code
    code++;
}



//
// print label
//

function printorders() {
    
    // open print dialog
    $('#print').dialog('open');

    //
    // build print data
    //

    // color list
    var color = ['Gold', 'Red', 'Yellow', 'Green', 'Blue', 'Purple', 'Brown', 'Black', 'White', 'Sliver'];

    // create print data builder object
    var builder = new epson.ePOSBuilder();
     var builder = new epson.ePOSBuilder();
    with (builder) {

        // paper layout
        if (layout) {
            addLayout(LAYOUT_LABEL, 580, 0, 15, -15, 25, 0);
        }

        // initialize (alphanumeic mode, smoothing)
        addTextLang('en');
        addTextSmooth(1);
        builder.addTextLang('en')
        builder.addTextSmooth(true);
        builder.addTextFont(builder.FONT_A);
        builder.addTextSize(3, 3);
        builder.addText('Hello,\tWorld!\n');
        builder.addCut(builder.CUT_FEED);

        // paper control
        // addFeedPosition(FEED_CURRENT_TOF);

        // paper control for first print
        // if (layout) {
        //     addFeedPosition(FEED_NEXT_TOF);
        // }

        // // start page mode
        // addPageBegin();

        // // format
        //  addPageArea(0, 0, 0, 0);

        // format - title
        
        // addPagePosition(0, 21);
        // addText('Name');
        // addPagePosition(0, 71);
        // addText('Color');
        // addPagePosition(0, 121);
        // addText('Code');

        // format - line

        // addText('Center');
        // addTextStyle(0, 1, 0);
        // addPagePosition(0, 42);
        // addText('                                          ');
        // addPagePosition(0, 92);
        // addText('                                2');
        // addTextStyle(0, 0, 0);

        // name
        // addPageArea(100, 0, 284, 50);
        // addPagePosition(0, 42);
        // addTextDouble(0, 1);
        // addText('Item A');
        // builder.addTextAlign(builder.ALIGN_CENTER);
        // builder.addFeedLine(2);
        // builder.addText('รายการอาหาร\n');
        // builder.addTextAlign(builder.ALIGN_LEFT);
        // builder.addText('#    ชื่ออาหาร        รายละเอียด    จำนวน \n');
        // builder.addText('1   ข้าวไข่ข้นกุ้งมะนาว               1 \n');
        // builder.addCut(builder.CUT_FEED);

        // color
        // addPageArea(100, 50, 284, 50);
        // addPagePosition(0, 33);
        // addTextDouble(0, 0);
        // addText(color[code % 10]);

        // end page mode
        addPageEnd();
        // paper control
        addFeedPosition(FEED_PEELING);
        // builder.addCut(builder.CUT_FEED);

    }

    //
    // send print data
    //

    // create print object
    var url = 'http://' + ipaddr + '/cgi-bin/epos/service.cgi?devid=' + devid + '&timeout=' + timeout;
    var epos = new epson.ePOSPrint(url);

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

    // set next item code
    code++;
}



 function testpaper() {
 //Create an ePOS-Print Builder object
 var builder = new epson.ePOSBuilder();
 //Create a print document
 builder.addTextLang('en')
 builder.addTextSmooth(true);
 builder.addText('Hello,\tWorld!\n');
 builder.addCut(builder.CUT_FEED);

 //Acquire the print document
 var request = builder.toString();
 alert(request);
 }
