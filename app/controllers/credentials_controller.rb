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
    @credential = Credential.new(params[:credential])
    @credential.user_id = @user.id
    respond_to do |format|
      if @credential.save
        format.html { redirect_to(user_credential_path(@user, @credential), :notice => 'Credential was successfully created.') }
        format.xml  { render :xml => @credential, :status => :created, :location => @credential }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @credential.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /credentials/1
  # PUT /credentials/1.xml
  def update
    @credential = Credential.find(params[:id])
    @credential.user_id = @user.id
    respond_to do |format|
      if @credential.update_attributes(params[:credential])
        format.html { redirect_to(user_credential_url(@user, @credential), :notice => 'Credential was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @credential.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /credentials/1
  # DELETE /credentials/1.xml
  def destroy
    @credential = Credential.find(params[:id])
    @credential.destroy

    respond_to do |format|
      format.html { redirect_to(user_credentials_url(@user)) }
      format.xml  { head :ok }
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
