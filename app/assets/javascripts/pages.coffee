# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->
  $ ->
    $('#schedule').fullCalendar({
      defaultView: 'agendaWeek'
      height: window.innerHeight * 0.9
      header:
        {
          left:   '',
          center: '',
          right:  'today prev,next'
        }
      allDaySlot: false
      events: '/rooms/' + $(location).attr('href').split("/")[5] + '/events_json'
      lazyFetching: false
      eventOverlap: false
      selectOverlap: false
    })

$(document).ready(ready)
$(document).on('page:load', ready)
