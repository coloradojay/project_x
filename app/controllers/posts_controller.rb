class PostsController < ApplicationController
  def index
  	@posts = Post.all
  end

  def new
  	@post = Post.new
  end

	def edit
		# this action is responsible for retrieving a specific bean
		@post = Post.find(params[:id])
	end

  def create
  	@post = Post.new(post_params)
  	@post.user = current_user
		# if the new post creation & save is sucessful, we want to redirect to the index
		if @post.save
			redirect_to posts_path
		else
			#if unsuccessful, reset to the new page
			render "new"
		end
  end

  def show
  	@post = Post.find(params[:id])
  	# Adding new comments to be posted onto a single post
  	@comment = Comment.new
  end

  def update # this action is responsible for saving an update to a specific post
		# Retrieving a specific post from the database
		@post = Post.find(params[:id])

		if @post.update_attributes(params.require(:post).permit(:title, :dog_breed, :body))
			redirect_to posts_path
		else
			#if unsuccessful, show to the edit page
			render "edit"
		end
	end

	def destroy
		@post = Post.find(params[:id])
		@post.destroy
		redirect_to posts_path
	end

  private
		def post_params
		 	params.require(:post).permit(:title, :dog_breed, :body, :user, :image)
	end
end
