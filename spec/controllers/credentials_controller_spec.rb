require 'spec_helper'

describe CredentialsController do

  def mock_credential(stubs={})
    @mock_credential ||= mock_model(Credential, stubs).as_null_object
  end

  describe "GET index" do
    it "assigns all credentials as @credentials" do
      Credential.stub(:all) { [mock_credential] }
      get :index
      assigns(:credentials).should eq([mock_credential])
    end
  end

  describe "GET show" do
    it "assigns the requested credential as @credential" do
      Credential.stub(:find).with("37") { mock_credential }
      get :show, :id => "37"
      assigns(:credential).should be(mock_credential)
    end
  end

  describe "GET new" do
    it "assigns a new credential as @credential" do
      Credential.stub(:new) { mock_credential }
      get :new
      assigns(:credential).should be(mock_credential)
    end
  end

  describe "GET edit" do
    it "assigns the requested credential as @credential" do
      Credential.stub(:find).with("37") { mock_credential }
      get :edit, :id => "37"
      assigns(:credential).should be(mock_credential)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created credential as @credential" do
        Credential.stub(:new).with({'these' => 'params'}) { mock_credential(:save => true) }
        post :create, :credential => {'these' => 'params'}
        assigns(:credential).should be(mock_credential)
      end

      it "redirects to the created credential" do
        Credential.stub(:new) { mock_credential(:save => true) }
        post :create, :credential => {}
        response.should redirect_to(credential_url(mock_credential))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved credential as @credential" do
        Credential.stub(:new).with({'these' => 'params'}) { mock_credential(:save => false) }
        post :create, :credential => {'these' => 'params'}
        assigns(:credential).should be(mock_credential)
      end

      it "re-renders the 'new' template" do
        Credential.stub(:new) { mock_credential(:save => false) }
        post :create, :credential => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested credential" do
        Credential.should_receive(:find).with("37") { mock_credential }
        mock_credential.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :credential => {'these' => 'params'}
      end

      it "assigns the requested credential as @credential" do
        Credential.stub(:find) { mock_credential(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:credential).should be(mock_credential)
      end

      it "redirects to the credential" do
        Credential.stub(:find) { mock_credential(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(credential_url(mock_credential))
      end
    end

    describe "with invalid params" do
      it "assigns the credential as @credential" do
        Credential.stub(:find) { mock_credential(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:credential).should be(mock_credential)
      end

      it "re-renders the 'edit' template" do
        Credential.stub(:find) { mock_credential(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested credential" do
      Credential.should_receive(:find).with("37") { mock_credential }
      mock_credential.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the credentials list" do
      Credential.stub(:find) { mock_credential }
      delete :destroy, :id => "1"
      response.should redirect_to(credentials_url)
    end
  end

end
