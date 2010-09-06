class CredentialsController < ApplicationController
  before_filter :authenticate
  before_filter :correct_user

  # GET /credentials/1
  # GET /credentials/1.xml
  def show
    @credential = Credential.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @credential }
    end
  end

  # GET /credentials/new
  # GET /credentials/new.xml
  def new
    @credential = Credential.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @credential }
    end
  end

  # GET /credentials/1/edit
  def edit
    @credential = Credential.find(params[:id])
  end

  # POST /credentials
  # POST /credentials.xml
  def create
    @credential  = current_user.credentials.build(params[:credential])
    if @credential.save
      flash[:success] = "Credentials created!"
      redirect_to root_path
    else
      render 'pages/home'
    end
  end


  # PUT /credentials/1
  # PUT /credentials/1.xml
  def update
    @credential = Credential.find(params[:id])
    @credential.user_id = @user.id
    if @credential.update_attributes(params[:credential])
      redirect_to(user_credential_url(@user, @credential), :notice => 'Credential was successfully updated.')
    else
      render :action => "edit"
    end
  end

  # DELETE /credentials/1
  # DELETE /credentials/1.xml
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
