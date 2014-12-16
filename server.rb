require 'sinatra'
require 'sinatra/reloader'
require 'pg'

set :bind, '0.0.0.0'

get '/' do
  send_file 'public/index.html'
end

post '/signup' do
  
end

post '/signin' do

end

get '/chats' do

end

post '/chats' do

end