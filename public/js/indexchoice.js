$(document).ready(function(){

  $('.container').on('click','.index_menu, .result_link',function(event){
    event.preventDefault();
    var destination = $(this).attr('href');
    $.ajax({
      type: 'GET',
      url: destination,
      beforeSend: function(){
        $('.index_sidebar_right').html('<div id="loader"></div>');
      },
      success: function(html){
        $('.index_sidebar_right').html(html);
      }

    });
  });


});
