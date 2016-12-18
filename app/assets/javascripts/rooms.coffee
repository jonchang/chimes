# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

window.lastEvent = null

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
      snapDuration: 10000
      events: $(location).attr('href') + '/events_json'
      lazyFetching: false
      eventOverlap: false
      selectOverlap: false
      eventStartEditable: true
      droppable: true
      drop: (date, jsEvent, ui, resourceId) ->
        $.post($(location).attr('href') + '/add_event', {'event[event_type_id]': $(this).attr('event-type'), 'event[datetime]': date.toISOString()},
          (data) ->
            $('#scheduler').fullCalendar('renderEvent', data)
            window.lastEvent = data.id
            return
        )
        return
      eventDrop: (event, delta, revertFunc, jsEvent, ui, view) ->
        $.post('/events/' + event.id, {'_method': 'PATCH', 'event[datetime]': event.start.toISOString()},
          (data) ->
            event.start = data.start
            event.end = data.end
            $('#scheduler').fullCalendar('updateEvent', event)
            window.lastEvent = null
            return
        )
        return
      eventRender: (event, element) ->
        $($(element).children()[0]).prepend('<span id="delete" class="removeEvent glyphicon glyphicon-trash pull-right"></span>')
        return
      eventClick: (event, jsEvent, view) ->
        if jsEvent.target.id == 'delete'
          $.post('/events/' + event.id, {'_method': 'DELETE'},
            (data) ->
              $('#scheduler').fullCalendar('removeEvents', data.id)
              window.lastEvent = null
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
    $("div[id^='et']").click(() ->
      if (window.lastEvent != null)
        $.post($(location).attr('href') + '/add_event', {'event[event_type_id]': $(this).attr('event-type'), 'event[datetime]': $($('#scheduler').fullCalendar('clientEvents', window.lastEvent)[0]).attr('end').toISOString()},
          (data) ->
            $('#scheduler').fullCalendar('renderEvent', data)
            window.lastEvent = data.id
            return
        )
    )
    $("span[id^='delete-et']").click(() ->
      if (confirm('Are you sure? This will delete all events of this type from all rooms.'))
        $.post('/event_types/' + $(this).attr('event-type'), {'_method': 'DELETE'})
    )
    $ -> $('[data-toggle="tooltip"]').tooltip()

$(document).ready(ready)
$(document).on('page:load', ready)
