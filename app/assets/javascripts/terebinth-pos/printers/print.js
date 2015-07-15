 $(function () {

        // Button
        $('#ticket, #coupon, #label').button();
        $('#setting').button({
            icons: {
                primary: "ui-icon-gear"
            }
        });

        // Setting Dialog
        $('#dialog').dialog({
            autoOpen: false,
            width: 420,
            buttons: {
                "OK": function () {
                    ipaddr = $('#ipaddr').val();
                    devid = $('#devid').val();
                    timeout = $('#timeout').val();
                    grayscale = $('#grayscale').is(':checked');
                    layout = $('#layout').is(':checked');
                    $(this).dialog("close");
                },
                "Cancel": function () {
                    $(this).dialog("close");
                }
            },
            show: "fade",
            hide: "drop",
            draggable: true,
            resizable: false,
            modal: true
        });

        // Printing Dialog
        $('#print').dialog({
            autoOpen: false,
            width: 320,
            show: "fade",
            hide: "drop",
            draggable: true,
            resizable: false,
            modal: true
        });

        // Error Dialog
        $('#receive, #error').dialog({
            autoOpen: false,
            width: 480,
            buttons: {
                "OK": function () {
                    $(this).dialog("close");
                }
            },
            show: "fade",
            hide: "drop",
            draggable: true,
            resizable: false,
            modal: true
        });

    });


    // Open Setting Dialog
    function openDialog() {
        $('#ipaddr').val(ipaddr);
        $('#devid').val(devid);
        $('#timeout').val(timeout);
        $('#grayscale').get(0).checked = grayscale;
        $('#layout').get(0).checked = layout;
        $('#dialog').dialog('open');

        console.log ("Setup Print jaaaaaaaaaaaaaaaaaaaaaaaaa")
    }

    // Settings
    var ipaddr = '192.168.0.26';
    var devid = 'local_printer';
    var timeout = '60000';
    var grayscale = false;
    var layout = false;

    // Queue Ticket Sequence Number
    var sequence = 1;

    // Coupon Serial Number
    var serial = 12301;

    // Item Code
    var code = 2012001;


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
        builder.addTextPosition(180);
        builder.addTextStyle(undefined,undefined,1);
        builder.addText('ใบสั่งอาหาร').addText('\n');
        builder.addTextStyle(undefined,undefined,0);
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
        builder.addTextPosition(10);
        builder.addTextStyle(undefined,undefined,0);

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


function printpayments(restuarant,table,name,surname,time,menu,total) {
     // open print dialog
    $('#print').dialog('open');
    console.log(total)
    var menu = JSON.parse("[" + menu + "]");

    // create print data builder object
    var builder = new epson.ePOSBuilder();
    with (builder) {

        // initialize (alphanumeic mode, smoothing)
        addTextLang('en');

        // paper control for first print
        // if (layout) {
        //     addFeedPosition(FEED_NEXT_TOF);
        // }

        // Paper Header
        addPageBegin();
        builder.addTextAlign(builder.ALIGN_CENTER).addText('\n');
        builder.addTextPosition(180);
        builder.addTextStyle(undefined,undefined,1);
        builder.addText('ใบเรียกเก็บเงิน').addText('\n');
        builder.addTextStyle(undefined,undefined,0);
        builder.addText('ร้าน :',' ').addText(restuarant).addText('\n');
        builder.addText('โต๊ะที่:',' ').addText(table).addText('\n');
        builder.addText('พนักงาน:\t').addText(name).addText(' ').addText(surname).addText('\n');
        builder.addText('วันที่/เวลา:').addText(' ').addText(time);
        builder.addText('\n');
        builder.addText('_________________________________________').addText('\n');
        builder.addFeedUnit(10);
        builder.addTextPosition(180);
        builder.addTextStyle(undefined,undefined,1,undefined);
        builder.addText('ค่าอาหาร/บริการ');
        builder.addText('\n');
        builder.addTextPosition(10);
        builder.addText('รายการ'),addTextPosition(190);
        builder.addText('จำนวน').addTextPosition(310);
        builder.addText('ราคา').addTextPosition(435);
        builder.addText('รวม').addText('\n')
        builder.addTextStyle(undefined,undefined,0,undefined);
        builder.addFeedUnit(20);


        // Paper Body
        for (i = 0; i < menu[0].length; i++) { 
            builder.addText(menu[0][i].menu);
            builder.addTextPosition(200);
            builder.addText(menu[0][i].value).addTextPosition(320);
            builder.addText(menu[0][i].menu_price).addTextPosition(440);
            builder.addText(parseFloat(menu[0][i].menu_price) * parseFloat(menu[0][i].value ));
            builder.addText('\n');

            if ((menu[0][i].remark) != null && (menu[0][i].remark) != "" ) {
                builder.addTextPosition(20);
                builder.addText('*').addText(menu[0][i].remark)
                builder.addText('\n'); 
            }              
        }

        builder.addFeedUnit(75);
        builder.addTextPosition(25);
        builder.addText('ค่าอาหาร');
        builder.addTextPosition(390);
        builder.addText('134.50').addText('\n');
        builder.addTextPosition(25);
        builder.addText('SERV.Charge');
        builder.addTextPosition(195);
        builder.addText('0 ').addText('%');
        builder.addTextPosition(400);
        builder.addText('0 บาท')
        builder.addText('\n');
        builder.addTextPosition(25);
        builder.addText('ส่วนลด');
        builder.addTextPosition(195);
        builder.addText('0 ').addText('%');
        builder.addTextPosition(400);
        builder.addText('0 ').addText('บาท').addText('\n');
        builder.addTextPosition(25);
        builder.addText('Vat');
        builder.addTextPosition(195);
        builder.addText('0 ').addText('%')
        builder.addTextPosition(400);
        builder.addText('0 ').addText('บาท').addText('\n');
        builder.addFeedUnit(40);
        builder.addText('รวมสุทธิ');
        builder.addTextPosition(390);
        builder.addTextStyle(undefined,true);
        builder.addText('134.50 ');
        builder.addTextStyle(undefined,0);
        builder.addText('บาท');






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