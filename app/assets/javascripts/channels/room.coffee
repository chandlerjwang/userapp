App.room = App.cable.subscriptions.create "RoomChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
  	append_message(data)
  	scroll_bottom()


$(document).on 'turbolinks:load', ->
  submit_message()
  scroll_bottom()
  get_current_user()


submit_message = () ->
  $('#message_content').on 'keydown', (event) ->
    if event.keyCode is 13 && !event.shiftKey
      $('#message-input-btn').click() #click the button
      event.target.value=""           #clear out the input area
      event.preventDefault()		  #don't enter new line  

scroll_bottom = () ->
  return if $('#messages').length < 1
  $('#messages').scrollTop($('#messages')[0].scrollHeight)

append_message = (data) ->
  if data.user_id == get_current_user()
	  msg = "
          <p style='text-align: right;'>
            <span>
              <span class='user-message'>#{data.content}</span>
              <strong> #{data.name}</strong>
            </span>
          </p>
          "
  else
    msg = "
          <p>
            <span>
              <strong>#{data.name} </strong>
              <span class='user-message'>#{data.content}</span>
            </span>
          </p>
          "
  $('#messages').append msg


get_current_user = () ->
  return if $('.temp-info').length == 0
  return $('.temp-info').data('temp')