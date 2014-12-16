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
  params = JSON.parse request.body.read
  username = params['username']
  password = params['password']

  db = Chatitude.create_db_connection('chatitude')
  Chatitude::UsersRepo.save(db, {
    :username => username,
    :password => password
  })
end

post '/signin' do

end

get '/chats' do

end

post '/chats' do

end

