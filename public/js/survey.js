$(document).ready(function(){

  $('#create_survey').on('click', '.add_answer', function(event){
    qId = $(this).prev().attr('data-question-id');
    $(this).prev().append('<input type="text" name="survey[' + qId + '][answer][]" placeholder="answer"><i class="icon-remove-sign"></i>');
  });

  $('#create_survey').on('click', '.add_question', function(event){
    qId = parseInt($(this).prev().children('.question_fields').eq(-1).attr('data-question-id'));
    $(this).prev().append('<div class="question_fields" data-question-id="' + (qId+1) + '"><input class="question_field" type="text" name="survey[' + (qId+1) + '][question]" placeholder="question"><i class="icon-remove-circle"></i></div><div class="add_answer">add answer</div>');
  });

  $('#create_survey').on('click', '.icon-remove-sign', function(){
    icon = $(this);
    icon.prev().remove();
    icon.remove();
  });

  $('#create_survey').on('click', '.icon-remove-circle', function(){
    $(this).parent().next().remove();
    $(this).parent().remove();
  });

});
