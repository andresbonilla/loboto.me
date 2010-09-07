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

  def edit
    @credential = Credential.find(params[:id])
  end


  def create
    @credential  = current_user.credentials.build(params[:credential])
    password = params[:credential][:password]
    if !current_user.has_password?(password)
      flash.now[:error] = "Invalid Password Bucket password."
      render 'new'
    else       
      if @credential.save
        flash[:success] = "Credentials created!"
        redirect_to current_user
      else
        render 'new'
      end
    end
  end



  def update
    @credential = Credential.find(params[:id])
    @credential.user_id = @user.id
    if @credential.update_attributes(params[:credential])
      redirect_to(user_credential_url(@user, @credential), :notice => 'Credential was successfully updated.')
    else
      render :action => "edit"
    end
  end

  def destroy
    @credential = Credential.find(params[:id])
    @credential.destroy
    redirect_to(user_credentials_url(@user))
  end
  
  private

    def correct_user
      @user = User.find(params[:user_id])
      redirect_to(root_path) unless current_user?(@user)
    end
    
end
