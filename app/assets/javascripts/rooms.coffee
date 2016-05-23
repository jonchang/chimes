# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->
  $ ->
    $('#scheduler').fullCalendar({
      defaultView: 'agendaWeek'
      header:
        {
            left:   '',
            center: '',
            right:  'today prev,next'
        }
      allDaySlot: false
      snapDuration: 1
      eventOverlap: false
      droppable: true
      drop: (date, jsEvent, ui, resourceId) ->
        alert 'Dropped on ' + date.format()
        return
    })
    $('#warning_time_used').change((e) ->
      $('#warning_time').prop('disabled', !$('#warning_time_used').is(':checked'))
    )
    $('#passing_time_used').change((e) ->
      $('#passing_time').prop('disabled', !$('#passing_time_used').is(':checked'))
    )
    $("div[id^='et']").draggable({
        revert: true
        revertDuration: 0
    })
    $("div[id^='et']").droppable()

$(document).ready(ready)
$(document).on('page:load', ready)
