require 'spec_helper'

describe CredentialsController do
  render_views
  
  before(:each) do
    @base_title = "loboto.me"
    @user = Factory(:user)
    @attr = {
      :service => "facebook",
      :username => "skjgaslkjfnasdfas",
      :password => "kjsndkfjnaskdfjn",
      :user_id => @user.id
    }
  end

  describe "access control" do

    it "should deny access to 'create'" do
      post :create, :user_id => @user.id
      response.should redirect_to(signin_path)
    end

    it "should deny access to 'destroy'" do
      delete :destroy, :id => 1, :user_id => @user.id
      response.should redirect_to(signin_path)
    end
    
  end
    
  describe "POST 'create'" do

    before(:each) do
      test_sign_in(@user)
    end

    describe "failure" do

      before(:each) do
        @attr = { :service => "", :username => "", :password => "  ", :user_id => @user.id }
      end

      it "should not create a credential" do
        lambda do
          post :create, :credential => @attr, :user_id => @user.id
        end.should_not change(Credential, :count)
      end

      it "should render the new credentials page" do
        post :create, :credential => @attr, :user_id => @user.id
        response.should render_template('credentials/new')
      end
      
    end

    describe "success" do
      
      it "should create a credential" do
        lambda do
          post :create, :credential => @attr, :user_id => @user.id
        end.should change(Credential, :count).by(1)
      end
    
      it "should redirect to the user's profile page" do
        post :create, :credential => @attr, :user_id => @user.id
        response.should redirect_to(@user)
      end
    
      it "should have a flash message" do
        post :create, :credential => @attr, :user_id => @user.id
        flash[:success].should =~ /Credentials created/i
      end
    
    end
  
  end

end
