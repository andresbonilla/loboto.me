class SessionsController < ApplicationController

  # Standard REST actions

  def new
    @title = "Sign in"
  end

  def create
    user = User.authenticate(params[:session][:username], params[:session][:password])
    if user.nil?
      flash.now[:error] = "Invalid email/password combination."
      @title = "Sign in"
      render 'new'
    else
      sign_in user
      update_activity_time
      redirect_to user
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end

end
