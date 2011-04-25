function notify(message) {
  $('.notice').html(message).show().highlight()
  $('#flashes').show()
}
