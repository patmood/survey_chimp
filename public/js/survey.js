$(document).ready(function(){
  

  $('.container').on('click', '.add_choice', function(event){
    qId = $(this).prev().attr('data-question-id');
    $(this).prev().append('<input type="text" name="survey[' + qId + '][choice][]" placeholder="Choice" class="survey-choice"><i class="icon-remove-sign"></i>');
  });

  $('.container').on('click', '.add_question', function(event){
    qId = $(this).prev().children('.question_fields').eq(-1).attr('data-question-id');
    if(qId == undefined){
      qId = 0;
    } else {
      qId = parseInt(qId);
    }
    $(this).prev().append('<div class="question_fields" data-question-id="' + (qId+1) + '"><input class="question_field survey-question" type="text" name="survey[' + (qId+1) + '][question]" placeholder="Question"><i class="icon-remove-circle"></i></div><div class="add_choice button purple">Add Choice</div>');
  });

  $('.container').on('click', '.icon-remove-sign', function(){
    icon = $(this);
    icon.prev().remove();
    icon.remove();
  });

  $('.container').on('click', '.icon-remove-circle', function(){
    $(this).parent().next().remove();
    $(this).parent().remove();
  });

});
