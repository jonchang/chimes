# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->
  $ ->
    $('#scheduler').fullCalendar({
      defaultView: 'agendaWeek'
      height: window.innerHeight * 0.9
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
        $.post($(location).attr('href') + '/add_event', {'event[event_type_id]': $(this).attr('event-type'), 'event[datetime]': date.toISOString()},
          (data) ->
            $('#scheduler').fullCalendar('addEventSource', [data])
            return
        )
        return
      eventDrop: (event, delta, revertFunc, jsEvent, ui, view) ->
        $.post('/events/' + event.id, {'_method': 'PATCH', 'event[datetime]': event.start.toISOString()},
          (data) ->
            event.prop('start', data.start)
            event.prop('end', data.end)
            $('#scheduler').fullCalendar('updateEvent', event)
            return
        )
        return
      eventRender: (event, element) ->
        element.prepend('<span event-id="' + event.id + '" class="removeEvent glyphicon glyphicon-trash pull-right"></span>')
        return
      eventClick: (event, jsEvent, view) ->
        $.post('/events/' + event.id, {'_method': 'DELETE'},
          (data) ->
            $('#scheduler').fullCalendar('removeEvents', data['id'])
            return
        )
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
