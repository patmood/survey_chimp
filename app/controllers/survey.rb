get '/survey/create' do
  if request.xhr?
    erb :_create_survey, layout: false
  else
    erb :create_survey
  end
end

post '/survey/create' do
  survey = Survey.create(:title => params[:title], :user_id => session[:user_id])
  unless survey.valid?
    redirect "/?error=#{"You're questionaire was invalid. Please try again later"}"
  else
    params[:survey].values.each do |par|
      if par[:choice]
        question = Question.create(:content => par[:question])
        par[:choice].each do |choice|
          question.choices << Choice.create(:content => choice)
        end
        survey.questions << question
      end
    end
    redirect '/'
  end
end

{
  "1"=>
    {"question"=>"aeljbfhkl", "choice"=>["bgjkg", "bhjkg", "bjlkh"]}, 
  "2"=>
    {"question"=>"vbhjl", "choice"=>["gvkl", "vg"]}, 
  "3"=>
    {"question"=>""}, 
  "4"=>
    {"question"=>""}
}


get '/survey/show/:id' do
  @survey = Survey.find(params[:id])
  erb :take_survey
end

get '/survey/list' do
  @surveys = Survey.all
  if request.xhr?
    erb :_list_surveys, layout: false
  else
    erb :list_surveys
  end  
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
  if request.xhr?
    erb :_my_surveys, layout: false
  else
    erb :my_surveys
  end
end

get '/survey/results/:survey_id' do
  @survey = []
  @title = Survey.find(params[:survey_id]).title
  @all_qs = Survey.find(params[:survey_id]).questions
  @all_qs.each do |question|
    @survey << question.choices.each_with_index.map do |choice,index|
      {question: question.content, content: choice.content, 
       count: Answer.where(choice_id: choice.id).count}
    end
  end
  @most = @survey.map{|s|s.map{|c|c[:count]}}.flatten.max
  puts "[[[[[[[[[[[[QUESTIONS : #{@survey.map{|s| s.map{ |c| c[:count]}}.flatten.max}]]]]]]]]]]]]]"
  
  if request.xhr?
    erb :_survey_results, layout: false
  else
    erb :survey_results
  end

end
