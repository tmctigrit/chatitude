require 'sinatra'
require 'sinatra/reloader'
require 'pg'
require 'json'
require 'pry-byebug'

set :bind, '0.0.0.0'

require_relative 'lib/chatitude.rb'

get '/' do
  send_file 'public/index.html'
end

post '/signup' do
  headers['Content-Type'] = 'application/json'
  
  puts params


  username = params['username']
  password = params['password']


  db = Chatitude.create_db_connection('chatitude')
  Chatitude::UsersRepo.save(db, {
    :username => username,
    :password => password
  })
  JSON.generate(params)

end

post '/signin' do

  headers['Content-Type'] = 'application/json'
  username = params['username']
 password = params['password']
# binding.pry
  db = Chatitude.create_db_connection('chatitude')
  user = Chatitude::UsersRepo.find_by_name(db, username)
  if user && password == user['password']
    Chatitude::UsersRepo.generate_api(db, user['id'])
    JSON.generate(user)
  end
end

get '/chats' do
  headers['Content-Type'] = 'application/json'
  db = Chatitude.create_db_connection('chatitude')
  chats = Chatitude::ChatsRepo.all(db)
  JSON.generate(chats)

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

