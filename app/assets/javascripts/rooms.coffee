# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->
  $ ->
    $('#scheduler').fullCalendar({
      defaultView: 'agendaWeek'
      height: window.innerHeight * 0.8
      header:
        {
            left:   '',
            center: '',
            right:  'today prev,next'
        }
      allDaySlot: false
      snapDuration: 1
      events: $(location).attr('href') + '/events_json'
      lazyFetching: false
      eventOverlap: false
      selectOverlap: false
      eventStartEditable: true
      droppable: true
      drop: (date, jsEvent, ui, resourceId) ->
        $.post($(location).attr('href') + '/add_event', {'event[event_type_id]': $(this).attr('event-type'), 'event[datetime]': date.toISOString()}, () -> $('#scheduler').fullCalendar('refetchEvents'))
        return
      eventDrop: (event, delta, revertFunc, jsEvent, ui, view) ->
        $.post('/events/' + event.id, {'_method': 'PATCH', 'event[datetime]': event.start.toISOString()}, () -> $('#scheduler').fullCalendar('refetchEvents'))
        return
      eventRender: (event, element) ->
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
    $('#trash').droppable({
      drop: (event, ui) ->
        $.post('/events/' + event.id, {'_method': 'DELETE'}, () -> $('#scheduler').fullCalendar('refetchEvents'))
        return
    })

$(document).ready(ready)
$(document).on('page:load', ready)
