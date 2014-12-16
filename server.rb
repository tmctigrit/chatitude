require 'sinatra'
require 'sinatra/reloader'
require 'pg'
require 'json'

set :bind, '0.0.0.0'

require_relative 'lib/chatitude.rb'

get '/' do
  send_file 'public/index.html'
end

post '/signup' do
  headers['Content-Type'] = 'application/json'
  username = params['username']
  password = params['password']

  db = Chatitude.create_db_connection('chatitude')
  Chatitude::UsersRepo.save(db, {
    :username => username,
    :password => password
  })

end

post '/signin' do
  headers['Content-Type'] = 'application/json'
  username = params['logusername']
  password = params['logpassword']

  db = Chatitude.create_db_connection('chatitude')
  user = Chatitude::UsersRepo.find_by_name(db, username)
  if user
    if password == user['password']
      user['token'] = SecureRandom.base64
    else
      status 401
    end
  else
    status 401
  end

  JSON.generate(user)

end

get '/chats' do

end

post '/chats' do

end

# $.ajax(function(){
#   url: '/signin',
#   method: 'post',
#   success: function(user){
#     console.log(user.apitoken);
#   }
# })

