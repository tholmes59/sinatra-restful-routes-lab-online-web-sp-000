class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/recipes' do
    @recipes = Recipe.all
    erb :index
  end 
  
  get '/recipes/new' do
    erb :new
  end
  
  post '/recipes' do 
    @recipes = Recipe.create(:name => params[:name], :ingredients => params[:ingredients], :cook_time => params[:cook_time])
    
    @recipes.save
    redirect :'/recipes/#{@recipes.id}'
  end 
  
  get '/recipes/:id' do
    @recipes = Recipe.find_by_id(params[:id])
    erb :show
  end 
  
  delete '/recipes/:id/delete' do 
    @recipes = Recipe.find_by_id(params[:id])
    @recipes.delete
    redirect '/recipes' 
  end 
  
  get '/recipes/:id/edit' do
    @recipes = Recipe.find_by_id(params[:id])
    erb :edit
  end 
  
  patch '/recipes' do
    @recipes = Recipe.find_by_id(params[:id])
    @recipes.name = params[:name]
    @recipes.ingredients = params[:ingredients]
    @recipes.cook_time = params[:cook_time]
    @recipes.save
    redirect '/recipes/#{@recipes.id}'
  end 

end
