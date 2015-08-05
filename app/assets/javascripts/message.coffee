$(document).ready ->
  dispatcher1 = new WebSocketRails('localhost:3000/websocket')
  dispatcher2 = new WebSocketRails('localhost:3000/websocket')
  dispatcher3 = new WebSocketRails('localhost:3000/websocket')
  channel1 = dispatcher1.subscribe('messages')
  channel2 = dispatcher2.subscribe('messages')
  channel3 = dispatcher3.subscribe('messages')
  channel1.bind 'new', (message) ->
    $('#user1 .messages').append '<p>' + message.text + '</p>'
    return
  channel2.bind 'new', (message) ->
    $('#user2 .messages').append '<p>' + message.text + '</p>'
    return
  channel3.bind 'new', (message) ->
    $('#user3 .messages').append '<p>' + message.text + '</p>'
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
