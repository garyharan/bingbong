/* menus */
$(function(){
  // http://blog.bernatfarrero.com/in-place-editing-with-javascript-jquery-and-rails-3/
  jQuery(".best_in_place").best_in_place()

  // edit the menu
  $('body').keyup(function(event){
    if (event.metaKey && event.keyCode == 69){
      $('.owner').toggle('slow')
    }
  })
  // if (location.href.match(/localhost/)){
  //   $('.owner').toggle('slow')
  //   $('#edit_menu_link').hide()
  // }
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
