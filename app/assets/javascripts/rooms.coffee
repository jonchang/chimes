# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->
  $ ->
    YUI().use 'aui-scheduler', (Y) ->
      events = [ {
        content: 'Partial Lunar Eclipse'
        endDate: new Date(2013, 3, 25, 5)
        startDate: new Date(2013, 3, 25, 1)
      } ]
      weekView = new (Y.SchedulerWeekView)
      new (Y.Scheduler)(
        boundingBox: '#myScheduler'
        date: new Date(2013, 3, 25)
        items: events
        render: true
        views: [ weekView ])
      return

$(document).ready(ready)
$(document).on('page:load', ready)
