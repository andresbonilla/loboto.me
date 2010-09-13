class CredentialsController < ApplicationController
  before_filter :authenticate
  before_filter :correct_user
  before_filter :session_expiry
  before_filter :update_activity_time
  
  # Standard REST actions
  
  def show
    @credential = Credential.find(params[:id])
  end

  def new
    @title = "New Credentials"
    @credential = Credential.new
  end

  def create
    @credential  = current_user.credentials.build(params[:credential]) 
    if @credential.save
      flash[:success] = "Credentials created!"
      redirect_to current_user
    else
      flash.now[:error] = "Your loboto.me password is incorrect."
      render 'new'
    end
  end

  def destroy
    @credential = Credential.find(params[:id])
    @credential.destroy
    redirect_to @user
  end
  
  private

    # This method makes sure the current user is the owner of the page being viewed.
    
    def correct_user
      @user = User.find(params[:user_id])
      redirect_to(root_path) unless current_user?(@user)
    end
    
end
