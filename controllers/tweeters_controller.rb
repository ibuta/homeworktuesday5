class PostsController < Sinatra::Base

	  set :root, File.join(File.dirname(__FILE__), '..')

	  set :views, Proc.new { File.join(root, "views") } 

	  configure :development do 
	  		register Sinatra::Reloader
	  end
	  
	  $tweeters = [{
	  		id: 0,
	  		title: "Tweet1",
	  		body: "Hello, Tweeters, my first post!"
	  		},
	  		{
	  		id: 1,
	  		title: "Tweet2",
	  		body: "Here it is the new post!"
	  		},
	  		{
	  		id: 2,
	  		title: "Tweet3",
	  		body: "Who's there?"
	  		}];


	post '/' do
		post = Tweet.new
		post.title = params[:title]
		post.body = params[:body]

		post.save
		redirect '/'
	end

	get '/new' do
		@post = Tweet.new
		@post.id =""
		@post.title =""
		@post.body =""

		erb :"posts/new"
	end

	delete '/id' do
		id = params[:id].to_i
		Tweet.destroy id
		redirect "/"
	end

	get '/:id/edit' do
		id = params[:id].to_i
		@post = $posts[id]
		erb :"posts/edit"
	end

	put '/:id' do
		id = params[:id].to_i
		post = Tweet.find id
		post.title = params[:title]
		post.body = params[:body]

		post.save
		redirect "/";
	end

	get '/:id' do
		id = params[:id].to_i
		@post = Tweet.find(id)

		erb :'posts/show'
	end

	get '/' do
		@title = "Tweets"
		@posts = Tweet.all
		erb :'posts/index'
	end

end