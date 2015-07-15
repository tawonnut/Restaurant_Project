function printorders(table,name,surname,time,menu) { 
    // open print dialog
    $('#print').dialog('open');
    console.log(menu)
    var menu = JSON.parse("[" + menu + "]");

    // create print data builder object
    var builder = new epson.ePOSBuilder();
    with (builder) {

        // initialize (alphanumeic mode, smoothing)
        addTextLang('en');
        addTextSmooth(1);

        // paper control for first print
        // if (layout) {
        //     addFeedPosition(FEED_NEXT_TOF);
        // }

        // start page mode
        addPageBegin();
        builder.addTextAlign(builder.ALIGN_CENTER).addText('\n');
        builder.addText('โต๊ะที่:',' ').addText(table).addText('\n');
        builder.addText('พนักงาน:\t').addText(name).addText(' ').addText(surname).addText('\n');
        builder.addText('วันที่/เวลา:').addText(' ').addText(time);
        builder.addText('\n');
        builder.addText('_________________________________________');
        builder.addText('\n');
        builder.addTextPosition(180);
        builder.addTextStyle(undefined,undefined,1,undefined);
        builder.addText('รายการอาหาร');
        builder.addText('\n');
        builder.addTextPosition(10);
        builder.addText('รายการ'),addTextPosition(410);
        builder.addText('จำนวน').addText('\n');
        builder.addTextStyle(undefined,undefined,0,undefined);

        for (i = 0; i < menu[0].length; i++) { 
            builder.addText(menu[0][i].menu);
            builder.addTextPosition(425);
            builder.addText(menu[0][i].value)
            builder.addText('\n');
            if ((menu[0][i].remark) != null && (menu[0][i].remark) != "" ) {
                builder.addTextPosition(20);
                builder.addText('*').addText(menu[0][i].remark)
                builder.addText('\n'); 
            }              
        }
        builder.addPageEnd();
        builder.addCut(builder.CUT_FEED);
        // builder.addPulse(builder.DRAWER_1,builder.PULSE_100);

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

    epos.send(builder.toString());
    // window.location.reload();
}







function printpayment(table) {
    
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
         addPageArea(0, 0, 0, 0);

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
        // builder.addText('ร้าน: Home Recipe \n พนักงาน: ชาริล ชัปป์บอม \n โต๊ะที่: 1 \n วันที่/เวลา: 2015-07-14 10:21:16 +0700 \n');
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
        var test = "dddddd"
        console.log(table)
        builder.addText(table);



       
        // end page mode
        addPageEnd();
        // paper control
        addFeedPosition(FEED_PEELING);
        builder.addCut(builder.CUT_FEED);

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
