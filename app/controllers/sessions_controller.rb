class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:login][:email]) unless params[:login][:email].empty?
    if user && user.authenticate(params[:login][:password])
      session[:user_id] = user.id.to_s
      redirect_to user_path(current_user)
    else
      render "sessions/new", alert: 'Unable to login'
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to login_path
  end
end
