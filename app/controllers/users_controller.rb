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
      session[:user_id] = @user.id.to_s
      redirect_to user_path(current_user)
    else
      render :new
    end
  end

  def show
  	@user = User.find(params[:id])
  end

  def update # this action is responsible for saving an update to a specific user
	# Retrieving a specific user from the database
		@user = User.find(params[:id])

		if @user.update_attributes(user_params)
			redirect_to users_path, alert: 'Profile Successfully Updated'
		else
		#if unsuccessful, show to the edit page
		render "edit", alert: 'Unable to update Profile'
	 end
  end

  def destroy
  	@user = User.find(params[:id])
  	@user = current_user.destroy
    session.delete(:user_id)
  	redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:user_name, :name, :email, :image, :password, :password_confirmation)
  end

end