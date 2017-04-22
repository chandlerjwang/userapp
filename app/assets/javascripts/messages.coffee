# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


message_appender = (content) ->
  $('#messages').append content

submit_message = () ->
  $('#message_content').on 'keydown', (event) ->
    if event.keyCode is 13
      $('#message-input-btn').click() #click the button
      event.target.value=""           #clear out the input area
      event.preventDefault()		  #don't enter new line

$(document).on 'turbolinks:load', ->
  submit_message()