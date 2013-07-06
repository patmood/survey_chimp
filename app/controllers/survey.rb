get '/survey/create' do
  erb :create_survey
end

post '/survey/create' do
  puts "===============================================\n\n"
  puts params.inspect
  puts "\n\n==============================================="
  survey = Survey.create(:title => params[:title])
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
  p @user

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
  @count = []
  @survey = Survey.find(params[:survey])
  @all_qs = @survey.questions
  @all_qs.each do |question|
    question.choices.each do |choice|
      @count << Answer.find_all_by_choice_id(choice.id).count
    end
  end
  erb :survey_results
end
