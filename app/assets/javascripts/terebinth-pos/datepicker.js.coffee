Datepickers = {

  showDatePicker: ->
    $("#today_date_picked").datepicker('show')

  showDatePicker2: ->
    $("#today_date_picked2").datepicker('show')

  enableDateTimePicker: ->
    $("#today_date_picked").datepicker {
      showWeek: true,
      firstDay: 1,
      dateFormat: "yy-mm-dd"
    }

    $("#today_date_picked2").datepicker {
      showWeek: true,
      firstDay: 1,
      dateFormat: "yy-mm-dd"
    }


  init: ->
    Datepickers.enableDateTimePicker()
    $(".show-datepicker").on 'click', Datepickers.showDatePicker
    $(".show-datepicker2").on 'click', Datepickers.showDatePicker2
}

$ -> Datepickers.init()