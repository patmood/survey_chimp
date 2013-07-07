$(document).ready(function() {

  //   $('a#sign-out').on("click", function (event) {
  //   event.preventDefault();
  //   var request = $.ajax({ url: $(this).attr('href'), type: 'delete' });
  //   request.done(function () { window.location = "/"; });
  // });


  $(document).on('focusin', 'input', function(){
    $(this).attr('data-placeholder', $(this).attr('placeholder'));
    $(this).attr('placeholder','');
  });

  $(document).on('focusout', 'input', function(){
      $(this).attr('placeholder', $(this).attr('data-placeholder'));
  });
});
    
