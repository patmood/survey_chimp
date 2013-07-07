get '/survey/create' do
  erb :create_survey
end

post '/survey/create' do
  puts "===============================================\n\n"
  puts params.inspect
  puts "\n\n==============================================="
  survey = Survey.create(:title => params[:title], :user_id => session[:user_id])
  params[:survey].values.each do |par|
    question = Question.create(:content => par[:question])
    par[:choice].compact.each do |choice|
      question.choices << Choice.create(:content => choice)
    end
    survey.questions << question
  end
  redirect '/'
end

get '/survey/show/:id' do
  @survey = Survey.find(params[:id])
  erb :take_survey
end

post '/survey/submit' do
  puts "===============================================\n\n"
  puts params.inspect
  puts "\n\n==============================================="

  @user = User.find(session[:user_id])
  c_s = @user.completed_surveys.create(survey_id: params[:survey])
  params[:choice].each do |question, choice|
    c_s.answers.create(question_id: question, choice_id: choice)
  end

  redirect '/'
end


get '/user/surveys' do
  @surveys = Survey.find_all_by_user_id(session[:user_id])
  erb :my_surveys
end

get '/survey/results/:survey_id' do
  @survey = []
  @all_qs = Survey.find(params[:survey_id]).questions
  @all_qs.each do |question|
    @survey << question.choices.each_with_index.map do |choice,index|
      {question: question.content, content: choice.content, 
       count: Answer.where(choice_id: choice.id).count}
    end
  end
  @most = @survey.map{|s|s.map{|c|c[:count]}}.flatten.max
  puts "[[[[[[[[[[[[QUESTIONS : #{@survey.map{|s| s.map{ |c| c[:count]}}.flatten.max}]]]]]]]]]]]]]"
  erb :survey_results
end