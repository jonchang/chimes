# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->
  $ ->
    $('#warning_time_used').change((e) ->
      $('#warning_time').prop('disabled', !$('#warning_time_used').is(':checked'))
    )
    $('#passing_time_used').change((e) ->
      $('#passing_time').prop('disabled', !$('#passing_time_used').is(':checked'))
    )

$(document).ready(ready)
$(document).on('page:load', ready)
