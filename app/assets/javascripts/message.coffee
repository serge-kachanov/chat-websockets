$(document).ready ->

  dispatcher = {}
  channel = {}

  $.each [1,2,3], (index, number) ->
    dispatcher[number] = new WebSocketRails('localhost:3000/websocket')
    channel[number] = dispatcher[number].subscribe('messages')
    channel[number].bind 'new', (message) ->
      $('#user' + [number] + ' .messages').append '<p>' + message.text + '</p>'
      $('#' + message.user + ' .messages p:last-child').css 'color', 'orange'
      return

  $('.chat button').click (event) ->
    event.preventDefault()
    id = $(this).closest('.chat').attr('id')
    $.ajax
      async: false
      type: 'post'
      url: '/messages'
      data:
        authenticity_token: $('#' + id + ' input[name=authenticity_token]').val()
        message:
          text: $('#' + id + ' input').val()
          user: id
    return
  return
