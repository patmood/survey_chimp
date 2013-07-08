get '/auth/twitter/callback' do
  # raise env['omniauth.auth'].to_yaml
  @user = User.parse_twitter(env['omniauth.auth'])
  session[:user_id] = @user.id  
  redirect '/'
end
