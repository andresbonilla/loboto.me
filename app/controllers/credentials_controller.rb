class CredentialsController < ApplicationController
  before_filter :authenticate
  before_filter :correct_user

  def show
    @credential = Credential.find(params[:id])
  end

  def new
    @title = "New Credentials"
    @credential = Credential.new
  end

  def create
    @credential  = current_user.credentials.build(params[:credential]) 
    @credential.crypted_password = params[:credential][:service_password]      
      if @credential.save
        flash[:success] = "Credentials created!"
        redirect_to current_user
      else
        render 'new'
      end
  end

  def destroy
    @credential = Credential.find(params[:id])
    @credential.destroy
    redirect_to @user
  end
  
  private

    def correct_user
      @user = User.find(params[:user_id])
      redirect_to(root_path) unless current_user?(@user)
    end
    
end
