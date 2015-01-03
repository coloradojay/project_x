class UsersController < ApplicationController
  def index
  	@users = User.all
  end

  def new
  	@user = User.new
  end

  def edit
  	@user = User.find(params[:id])
  end

  def create
  	@user = User.new(user_params)

  	if @user.save
  		redirect_to users_path
  	else
  		render "new"
  	end
  end

  def show
  	@user = User.find(params[:id])
  end

  def update # this action is responsible for saving an update to a specific user
	# Retrieving a specific user from the database
		@user = User.find(params[:id])

		if @user.update_attributes(params.require(:user).permit(:user_name, :name, :email, :image))
			redirect_to users_path
		else
		#if unsuccessful, show to the edit page
		render "edit"
	end

  def destroy
  	@user = User.find(params[:id])
  	@user.destroy
  	redirect_to users_path
  end

  private

  def user_params
    params.require(:user).permit(:user_name, :name, :email, :image)
  end

end