require 'sinatra/base'
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do

  end

  get '/posts/new' do 
    erb :new
  end

  post '/posts/new' do
    @blog_post = Post.create(params)
    redirect "/posts"
  end

  get '/posts' do
    @all_posts = Post.all
    erb :index
  end

  get '/posts/:id' do
    @post = Post.find(params[:id])
    erb :show
  end

  get '/posts/:id/edit' do
    @post = Post.find(params[:id])
    erb :edit
  end

  patch '/posts/:id' do 
    @post = Post.find(params[:id]) ##find the id first
    @post.name = params["name"]
    @post.content = params["content"]
    @post.save ##syntax is passing through what we're updating
    redirect "/posts/#{@post.id}" ##interpolate because url is a string, and will look for a :id and not a number id, need the instance of post
  end

  delete '/posts/:id/delete' do
    @post = Post.find(params[:id]).destroy
    "#{@post.name} was deleted"
    # redirect "/posts"
  end

end