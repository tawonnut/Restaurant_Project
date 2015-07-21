 $(function () {

        // Button
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

   


function printorders(table,name,surname,time,menu) { 
    // open print dialog
    $('#print').dialog('open');
    console.log(menu);
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
     
        builder.addTextAlign(builder.ALIGN_CENTER);
        builder.addTextStyle(undefined,undefined,1);
        builder.addText('ใบสั่งอาหาร').addText('\n');
        builder.addTextStyle(undefined,undefined,0);
        builder.addText('โต๊ะที่:',' ').addText(table).addText('\n');
        builder.addText('พนักงาน: ').addText(name).addText(' ').addText(surname).addText('\n');
        builder.addText('วันที่/เวลา:').addText(' ').addText(time);
        builder.addText('\n');
        builder.addText('_________________________________________');
        builder.addText('\n');
        builder.addTextStyle(undefined,undefined,1,undefined);
        builder.addText('รายการอาหาร');
        builder.addText('\n');
        builder.addTextPosition(10);
        builder.addText('รายการ'),addTextPosition(400);
        builder.addText('จำนวน').addText('\n');
        builder.addTextStyle(undefined,undefined,0);

        for (i = 0; i < menu[0].length; i++) { 
            if (menu[0][i].cancle === false) {
                builder.addTextAlign(builder.ALIGN_LEFT);
                builder.addText(menu[0][i].menu);
                builder.addTextPosition(450);
                builder.addText(menu[0][i].value);
                builder.addText('\n');

                if ((menu[0][i].remark) != null && (menu[0][i].remark) != "" ) {
                    builder.addTextAlign(builder.ALIGN_LEFT);
                    builder.addTextPosition(20);
                    builder.addText('*').addText(menu[0][i].remark)
                    builder.addText('\n'); 
                }       
            }             
        }

        builder.addCut(builder.CUT_FEED);
      
    }
  
  
    // create print object
    var url1 = 'http://' + ipaddr + '/cgi-bin/epos/service.cgi?devid=' + devid + '&timeout=' + timeout;
    var epos2 = new epson.ePOSPrint(url1);

    // register callback function
    epos2.onreceive = function (res) {
        // close print dialog
        $('#print').dialog('close');
        // print failure
        if (!res.success) {
            // show error message
            $('#receive').dialog('open');
        }
    }
    // register callback function
    epos2.onerror = function (err) {
        // close print dialog
        $('#print').dialog('close');
        // show error message
        $('#error').dialog('open');
    }

    epos2.send(builder.toString());
    // window.location.reload();

 
}

function openDrawer() { 
    // open print dialog
    $('#print').dialog('open');
       
    // create print data builder object
    var builder = new epson.ePOSBuilder();
    with (builder) {

        // initialize (alphanumeic mode, smoothing)
        
        builder.addPulse(builder.DRAWER_1,builder.PULSE_100); 
    }
  
    // create print object
    var url1 = 'http://' + ipaddr + '/cgi-bin/epos/service.cgi?devid=' + devid + '&timeout=' + timeout;
    var epos2 = new epson.ePOSPrint(url1);

    // register callback function
    epos2.onreceive = function (res) {
        // close print dialog
        $('#print').dialog('close');
        // print failure
        if (!res.success) {
            // show error message
            $('#receive').dialog('open');
        }
    }
    // register callback function
    epos2.onerror = function (err) {
        // close print dialog
        $('#print').dialog('close');
        // show error message
        $('#error').dialog('open');
    }

    epos2.send(builder.toString());    
}

function printpayments(restuarant,table,name,surname,time,menu,menudrink,menudessert,total,discount) {
     // open print dialog
    $('#print').dialog('open');
    
    var menu = JSON.parse("[" + menu + "]");
    var menudrink = JSON.parse("[" + menudrink + "]");
    var menudessert = JSON.parse("[" + menudessert + "]");

    var disbath = (total*discount)/100;
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
        builder.addText('รายการ'),addTextPosition(230);
        builder.addText('จำนวน').addTextPosition(330);
        builder.addText('ราคา').addTextPosition(435);
        builder.addText('รวม').addText('\n')
        builder.addTextStyle(undefined,undefined,0,undefined);
        builder.addFeedUnit(20);


        // Paper Body
        for (i = 0; i < menu[0].length; i++) { 
            builder.addText(menu[0][i].menu);
            builder.addTextPosition(250);
            builder.addText(menu[0][i].value).addTextPosition(340);
            builder.addText(menu[0][i].menu_price).addTextPosition(440);
            builder.addText(parseFloat(menu[0][i].menu_price) * parseFloat(menu[0][i].value ));
            builder.addText('\n');

            if ((menu[0][i].remark) != null && (menu[0][i].remark) != "" ) {
                builder.addTextPosition(20);
                builder.addText('*').addText(menu[0][i].remark);
                builder.addText('\n'); 
            }              
        }

         for (i = 0; i < menudrink[0].length; i++) { 
            builder.addText(menudrink[0][i].menu);
            builder.addTextPosition(250);
            builder.addText(menudrink[0][i].value).addTextPosition(340);
            builder.addText(menudrink[0][i].menu_price).addTextPosition(440);
            builder.addText(parseFloat(menudrink[0][i].menu_price) * parseFloat(menudrink[0][i].value ));
            builder.addText('\n');

            if ((menudrink[0][i].remark) != null && (menudrink[0][i].remark) != "" ) {
                builder.addTextPosition(20);
                builder.addText('*').addText(menudrink[0][i].remark);
                builder.addText('\n'); 
            }              
        }
         for (i = 0; i < menudessert[0].length; i++) { 
            builder.addText(menudessert[0][i].menu);
            builder.addTextPosition(250);
            builder.addText(menudessert[0][i].value).addTextPosition(340);
            builder.addText(menudessert[0][i].menu_price).addTextPosition(440);
            builder.addText(parseFloat(menudessert[0][i].menu_price) * parseFloat(menudessert[0][i].value ));
            builder.addText('\n');

            if ((menudessert[0][i].remark) != null && (menudessert[0][i].remark) != "" ) {
                builder.addTextPosition(20);
                builder.addText('*').addText(menudessert[0][i].remark);
                builder.addText('\n'); 
            }              
        }


        builder.addFeedUnit(75);
        builder.addTextPosition(25);
        builder.addText('ค่าอาหาร');
        builder.addTextPosition(390);
        builder.addText(total).addText(' บาท')
        builder.addText('\n');
        builder.addTextPosition(25);
        builder.addText('ส่วนลด');
        builder.addTextPosition(195);
        builder.addText(discount).addText(' %');
        builder.addTextPosition(400);
        builder.addText(disbath).addText(' บาท').addText('\n');
        builder.addTextPosition(25);
        builder.addText('SERV.Charge');
        builder.addTextPosition(195);
        builder.addText('0 ').addText('%');
        builder.addTextPosition(400);
        builder.addText('0 บาท');
        builder.addText('\n');
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
        builder.addText(total-disbath);
        builder.addTextStyle(undefined,0);
        builder.addText(' บาท').addText('\n');
        builder.addFeedUnit(50);
        builder.addTextPosition(155);
        builder.addText('**รับเฉพาะเงินสด**');

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
    var disbath = (total*discount)/100;
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



function printbills() {
     // open print dialog
     restuarant = $("#restuarant").val();
     table = $("#table").val();
     name = $("#name").val();
     surname = $("#surname").val();
     time = $("#time").val();
     menu = $("#menu").val();
     menudrink = $("#menudrink").val();
     menudessert = $("#menudessert").val();
     total = $("#total").val();
     discount = $("#discount").val();

    $('#print').dialog('open');
    
    var menu = JSON.parse("[" + menu + "]");
    var menudrink = JSON.parse("[" + menudrink + "]");
    var menudessert = JSON.parse("[" + menudessert + "]");
    var cash = $('#cash').val();
    submit = cash - total;
    var disbath = (total*discount)/100;

    

    // create print data builder object
     
    var builder = new epson.ePOSBuilder();
    with (builder) {
     
       builder.addTextLang('en');
   
        // Paper Header
        addPageBegin();
        builder.addTextAlign(builder.ALIGN_CENTER).addText('\n');
        builder.addTextStyle(undefined,undefined,1);
        builder.addTextPosition(90);
        builder.addText('ใบเสร็จรับเงิน/ใบกำกับภาษีอย่างย่อ').addText('\n');
        builder.addTextPosition(150);
        builder.addTextStyle(undefined,undefined,0);
        builder.addText('ร้าน :',' ').addText(restuarant).addText('\n');
        builder.addFeedUnit(10);
        builder.addText('Tax ID NO. ').addText('0105537143215').addText('\n');
        builder.addText('โต๊ะที่:',' ').addText(table).addText('\n');
        builder.addText('พนักงาน:\t').addText(name).addText(' ').addText(surname).addText('\n');
        builder.addText('วันที่/เวลา:').addText(' ').addText(time).addText('\n');
        builder.addText('_________________________________________').addText('\n');

        //Top menu
        builder.addFeedUnit(10);
        builder.addTextPosition(180);
        builder.addTextStyle(undefined,undefined,1,undefined);
        builder.addText('ค่าอาหาร/บริการ');
        builder.addText('\n');
        builder.addTextPosition(10);
        builder.addText('รายการ').addTextPosition(230);
        builder.addText('จำนวน').addTextPosition(330);
        builder.addText('ราคา').addTextPosition(435);
        builder.addText('รวม').addText('\n');
        builder.addTextStyle(undefined,undefined,0,undefined);
        builder.addFeedUnit(20);


        // Var loop
        for (i = 0; i < menu[0].length; i++) { 
            builder.addText(menu[0][i].menu);
            builder.addTextPosition(250);
            builder.addText(menu[0][i].value).addTextPosition(350);
            builder.addText(menu[0][i].menu_price).addTextPosition(440);
            builder.addText(parseFloat(menu[0][i].menu_price) * parseFloat(menu[0][i].value ));
            builder.addText('\n');

            if ((menu[0][i].remark) != null && (menu[0][i].remark) != "" ) {
                builder.addTextPosition(20);
                builder.addText('*').addText(menu[0][i].remark);
                builder.addText('\n'); 
            }              
        }

         for (i = 0; i < menudrink[0].length; i++) { 
            builder.addText(menudrink[0][i].menu);
            builder.addTextPosition(250);
            builder.addText(menudrink[0][i].value).addTextPosition(350);
            builder.addText(menudrink[0][i].menu_price).addTextPosition(440);
            builder.addText(parseFloat(menudrink[0][i].menu_price) * parseFloat(menudrink[0][i].value ));
            builder.addText('\n');

            if ((menudrink[0][i].remark) != null && (menudrink[0][i].remark) != "" ) {
                builder.addTextPosition(20);
                builder.addText('*').addText(menudrink[0][i].remark);
                builder.addText('\n'); 
            }              
        }

        for (i = 0; i < menudessert[0].length; i++) { 
            builder.addText(menudessert[0][i].menu);
            builder.addTextPosition(250);
            builder.addText(menudessert[0][i].value).addTextPosition(350);
            builder.addText(menudessert[0][i].menu_price).addTextPosition(440);
            builder.addText(parseFloat(menudessert[0][i].menu_price) * parseFloat(menudessert[0][i].value ));
            builder.addText('\n');

            if ((menudessert[0][i].remark) != null && (menudessert[0][i].remark) != "" ) {
                builder.addTextPosition(20);
                builder.addText('*').addText(menudessert[0][i].remark);
                builder.addText('\n'); 
            }              
        }


            // Paper Body
        builder.addFeedUnit(30);
        builder.addTextPosition(25);
        builder.addText('ค่าอาหาร');
        builder.addTextPosition(390);
        builder.addText(total).addText(' บาท').addText('\n');
        builder.addTextPosition(25);
        builder.addText('ส่วนลด');
        builder.addTextPosition(195);
        builder.addText(discount).addText(' %');
        builder.addTextPosition(400);
        builder.addText(disbath).addText(' บาท').addText('\n');
        builder.addTextPosition(25);
        builder.addText('SERV.Charge');
        builder.addTextPosition(195);
        builder.addText('0 ').addText('%');
        builder.addTextPosition(400);
        builder.addText('0 บาท');
        builder.addText('\n');
        builder.addTextPosition(25);
        builder.addText('VAT');
        builder.addTextPosition(195);
        builder.addText('0 ').addText('%')
        builder.addTextPosition(400);
        builder.addText('0 ').addText('บาท').addText('\n');
        builder.addFeedUnit(10);
        builder.addText('รวมสุทธิ');
        builder.addTextPosition(390);
        builder.addTextStyle(undefined,true);
        builder.addText(total-disbath);
        builder.addTextStyle(undefined,0);
        builder.addText(' บาท').addText('\n');
        builder.addFeedUnit(20);
        builder.addText('รับเงิน');
        builder.addTextPosition(360);
        builder.addText(cash).addText(' บาท').addText('\n');
        builder.addText('ชำระ');
        builder.addTextPosition(390);
        builder.addText(total-disbath).addText(' บาท').addText('\n');
        builder.addText('เงินทอน');
        builder.addTextPosition(390);
        builder.addText(cash-(total-disbath)).addText(' บาท').addText('\n');
        builder.addFeedUnit(30);
        builder.addText('Cashier Sign: ').addText('___________________').addText('\n');
        builder.addFeedUnit(30);
        builder.addTextPosition(180);
        builder.addText('ขอบคุณที่ใช้บริการ');

        builder.addPageEnd();
        builder.addCut(builder.CUT_FEED);
        builder.addPulse(builder.DRAWER_1,builder.PULSE_100);
    }

    $("#money").val(cash-(total-disbath));
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
    
}