$(function(){
  if ("placeholder" in document.createElement( "input" )){ return }

  $('input[placeholder]').each(function(){
    $(this).val($(this).attr('placeholder')).css('color', '#999')
  }).focus(function(){
    var placeholder = $(this).attr('placeholder')
    $(this).val( placeholder == $(this).val() || $(this).val() == '' ? '' : $(this).val() ).css('color', '#333')
  }).blur(function(){
    var placeholder = $(this).attr('placeholder')
    if ($(this).val() == '') {
      $(this).val(placeholder).css('color', '#999')
    }
  });
});
