require('sinatra')
require('sinatra/contrib/all')

require_relative('./models/film')
also_reload('./models/*')

get '/films' do
    @films = Film.all
    erb ( :index )
end

get '/films/:id' do
    @film = Film.find_by_id(params['id'])
    erb ( :film )
end