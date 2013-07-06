get '/survey/create' do
  erb :create_survey
end

post '/survey/create' do
  puts "===============================================\n\n"
  puts params.inspect
  puts "\n\n==============================================="
  survey = Survey.create(:title => params[:title])
  params[:survey].values.select {|a| a[:choice]}.each do |par|
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
  redirect '/'
end
