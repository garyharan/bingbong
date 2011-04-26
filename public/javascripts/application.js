function rails_notify(message) {
  $('.notice').html(message).show().highlight()
  $('#flashes').show()
}

function rails_alert(message) {
  $('.alert').html(message).show().highlight()
  $('#flashes').show()
}
