  $("#cash").keypress(function (e) {
  	console.log ("loggg");
            if (e.keyCode == '13') {
                e.preventDefault();
                alert("ff");
            }
        });