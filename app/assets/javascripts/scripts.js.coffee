# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$ ->

  $body_container = $('#body_container')

  message_template = Handlebars.compile($('#message_template').html())

  loadCalendar()

  $("#new_event").on("ajax:success", (e, data, status, xhr) ->
    message = 
      type: "success"
      message: "Event was successfully created!"
    display_form_message "#new_event", message
  ).on "ajax:error", (e, xhr, status, error) ->
    message = 
      type: "success"
      message: xhr.responseText
    display_form_message "#new_event", message

  display_form_message = (element, message) ->
    $(element).prepend message_template(message)
    $(window).scrollTop(0)
    setTimeout( ->
      console.log("done")
    , 2000)

  $('a[data-ajax=true').click( (e) ->
    e.preventDefault();
    $this = $(this)
    linkPushState($this.data('url'), (data) ->
      $body_container.html(data)
      console.log("sadf")
    , true)
    return false
  )


loadCalendar = ->
  $('#calendar').fullCalendar(
    header:
      left: 'prev'
      center: 'title'
      right: 'next'
    defaultDate: '2014-06-12'
    editable: false
    events:
      url: '/events.json'
      error: ->
    loading: (bool) ->
      $('#loading').toggle(bool)
  )
