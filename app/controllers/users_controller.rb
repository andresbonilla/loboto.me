class UsersController < ApplicationController
  before_filter :session_expiry, :only => [:show]
  before_filter :update_activity_time, :only => [:show]
  before_filter :authenticate, :only => [:show]
  before_filter :correct_user, :only => [:show]
  
  def new
    @title = "Sign up"
    @user = User.new
  end

  def show
    @credentials = @user.credentials
    @title = @user.username
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to loboto.me!"
      redirect_to @user
    else
      if @user.errors.any?
        flash.now[:error] = @user.errors.full_messages.first
      end
      @title = "Sign up"
      render 'new'
    end
  end
  
  private
  
    def authenticate
      deny_access unless signed_in?
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

end
