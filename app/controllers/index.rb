get '/' do
  @error = params[:error] if params[:error]
  p @error
  unless session[:user_id]
    @user = User.new
    erb :sign_in
  else
    @surveys = Survey.all
    erb :index
  end
end

#----------- SESSIONS -----------


get '/sessions/new' do
  # render sign-in page
  @user = User.new
  @email = nil
  erb :sign_in
end

post '/sessions' do
  # sign-in
  @email = params[:email]
  user = User.authenticate(@email, params[:password])
  if user
    # successfully authenticated; set up session and redirect
    session[:user_id] = user.id
    redirect '/'
  else
    # an error occurred, re-render the sign-in form, displaying an error
    @error = "Invalid email or password."
    erb :sign_in
  end
end

delete '/sessions/:id' do
  # sign-out -- invoked via AJAX
  return 401 unless params[:id].to_i == session[:user_id].to_i
  session[:user_id] = nil
  200
end

get '/logout' do
  session[:user_id] = nil
  redirect '/'
end 


#----------- USERS -----------
get '/login' do
  @user = User.new
  if request.xhr?
    erb :_signin, layout: false
  else
    erb :sign_in
  end
end

get '/signup' do
  @user = User.new
  if request.xhr?
    puts "hello"
    erb :_signup, layout: false
  else
    erb :sign_up
  end
end

get '/users/new' do
  # render sign-up page
  @user = User.new
  erb :sign_up
end

post '/users' do
  # sign-up
  @user = User.new params[:user]
  if @user.save
    # successfully created new account; set up the session and redirect
    session[:user_id] = @user.id
    redirect '/'
  else
    # an error occurred, re-render the sign-up form, displaying errors
    erb :sign_up
  end
end

get '/user/:id/profile' do
  if params[:id].to_i == session[:user_id]
    @user = User.find(params[:id])
    erb :profile
  else
    redirect '/'
  end
end
