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
      events: 'events_json'
      lazyFetching: false
      eventOverlap: false
      eventStartEditable: true
      droppable: true
      drop: (date, jsEvent, ui, resourceId) ->
        alert 'Dropped on ' + date.format()
        $.post('add_event', {}, () -> $('#scheduler').fullCalendar('render'))
        return
      eventDrop: (event, delta, revertFunc, jsEvent, ui, view) ->
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
