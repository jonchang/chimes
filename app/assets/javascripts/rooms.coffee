# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->
  $ ->
    $('#scheduler').fullCalendar({
      defaultView: 'agendaWeek',
      header:
        {
            left:   '',
            center: '',
            right:  'today prev,next'
        }
      allDaySlot: false,
      eventOverlap: false
    })

$(document).ready(ready)
$(document).on('page:load', ready)
