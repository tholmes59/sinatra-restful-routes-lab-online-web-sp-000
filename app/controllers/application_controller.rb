class ApplicationController < Sinatra::Base
  
  set :views, Proc.new { File.join(root, "../views/")
  
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end
  
  get '/recipes/new' do
    erb :new
  end
  
   get '/recipes' do
    @recipes = Recipe.all
    erb :index
  end 
  
  post '/recipes' do 
    @recipe = Recipe.create(:name => params[:name], :ingredients => params[:ingredients], :cook_time => params[:cook_time])
    
    @recipe.save
    redirect :"/recipes/#{@recipe.id}"
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
    @recipe = Recipe.find_by_id(params[:id])
    @recipe.name = params[:name]
    @recipe.ingredients = params[:ingredients]
    @recipe.cook_time = params[:cook_time]
    @recipe.save
    redirect "/recipes/#{@recipe.id}"
  end 

end




