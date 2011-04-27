/* menus */
$(function(){
  // update categories in menu
  $('.category_name').each(function(){
    $(this).mouseup(function(){
      $('#' + this.id).hide()
      $('#edit_' + this.id).show().find('input[type=text]').focus()
    })
  });
});

/* flashes */
function rails_notify(message) {
  $('.notice').html(message).show().highlight()
  $('#flashes').show()
}

function rails_alert(message) {
  $('.alert').html(message).show().highlight()
  $('#flashes').show()
}
