$(function(){
  // pre launch
  $('input:radio').click(function(){
    if ($(this).val() == 'normal'){
      $('.phone').hide()
    } else {
      $('.phone').show()
    }
  })


  // home page 
  $(window).keydown(function(e){
    switch (e.which){
      case 224: // Cmd in FF
      case 91:  // Cmd in Safari
      case 67:  // Cmd+c Ctrl+c
      case 17:  // Ctrl
      case 33:  // PageUp 
      case 34:  // PageDown
      case 13:  // enter
        break;
      case 69: // e for admin edit
        if (e.metaKey){
          $('.owner').toggle('slow')
        }
      default:
        $('#search_location').focus()
        break;
    }
  });
  
  $('input[type=text]#search').focus().keypress(function(event){
    if (event.keyCode == 13) {
      $("#instructions").hide()
      $("#tag_line").hide()
      $('#google_map').attr('src', googleMapUrl($('#search').val()))
      $('#google_map').css({display: 'block'});
    }
  })

  /* menus */
  // http://blog.bernatfarrero.com/in-place-editing-with-javascript-jquery-and-rails-3/
  jQuery(".best_in_place").best_in_place()

  /* admin */
  $('input[data-onblur="submit"]').live('blur', function(){
    if ($(this).data('changed')) {
      $(this).parents('form:first').submit();
    }
  }).keypress(function(event){
    $(this).data('changed', true);
  });
});

function googleMapUrl(address){
  var components = address.split(',')
  var url_address = jQuery.map(address.split(','), function(string, i){
    return String(string).replace(/^\s+|\s+$/g, '')
  }).join(',')

  return [ "http://maps.google.com/maps/api/staticmap?",
      'size=250x150',
      "&zoom=13",
      "&markers=size:mid|color:0xE35524|",
      unescape(url_address),
      "&sensor=false" ].join('')
}

/* flashes */
function rails_notify(message) {
  $('.notice').html(message).show().highlight()
  $('#flashes').show()
}

function rails_alert(message) {
  $('.alert').html(message).show().highlight()
  $('#flashes').show()
}
