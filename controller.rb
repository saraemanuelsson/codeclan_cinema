require('sinatra')
require('sinatra/contrib/all')

require_relative('./models/film')
also_reload('./models/*')

get '/films' do
    @films = Film.all
    erb ( :index )
end

get '/films/130' do
    erb ( :avengers )
end

get '/films/131' do
    erb ( :theory_of_everything )
end

get '/films/132' do
    erb ( :fast_and_furious )
end