get '/survey/create' do
  erb :create_survey
end

post '/survey/create' do
  puts "===============================================\n\n"
  puts params.inspect
  puts "\n\n==============================================="
end
