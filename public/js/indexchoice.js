$(document).ready(function(){

  $('.container').on('click','.index_menu',function(event){
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


  // $('#list_surveys').on('click',function(event){
  //   event.preventDefault();
  //   $.ajax({
  //     type: 'GET',
  //     url: '/survey/list',
  //     beforeSend: function(){
  //       $('.container').html('<div id="loader"></div>');
  //     },
  //     success: function(html){
  //       $('.container').replaceWith(html);
  //     }

  //   });
  // });

  // $('#create_survey').on('click',function(event){
  //   event.preventDefault();
  //   $.ajax({
  //     type: 'GET',
  //     url: '/survey/create',
  //     beforeSend: function(){
  //       $('.container').html('<div id="loader"></div>');
  //     },
  //     success: function(html){
  //       $('.container').replaceWith(html);
  //     }

  //   });
  // });

  // $('#my_surveys').on('click',function(event){
  //   event.preventDefault();
  //   $.ajax({
  //     type: 'GET',
  //     url: '/user/surveys',
  //     beforeSend: function(){
  //       $('.container').html('<div id="loader"></div>');
  //     },
  //     success: function(html){
  //       $('.container').replaceWith(html);
  //     }

  //   });
  // });

});
