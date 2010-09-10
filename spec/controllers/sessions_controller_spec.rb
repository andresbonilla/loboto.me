require 'spec_helper'

describe SessionsController do
  render_views

  describe "GET 'new'" do

    it "should be successful" do
      get :new
      response.should be_success
    end
    
    it "should have the right title" do
      base_title = "loboto.me"
      get 'new'
      response.should have_selector("title", :content => base_title + " | Sign in")
    end
  end
  
  describe "POST 'create'" do
    describe "invalid sign in" do
      before(:each) do
        @attr = { :username => "sdfgsdfdgv", :password => "invalid" }
      end

      it "should re-render the new page" do
        post :create, :session => @attr
        response.should render_template('new')
      end

      it "should have a flash.now message" do
        post :create, :session => @attr
        flash.now[:error].should =~ /invalid/i
      end
    end
      
      
    describe "with valid email and password" do

      before(:each) do
        @user = Factory(:user)
        @attr = { :username => @user.username, :password => @user.password }
      end

      it "should sign the user in" do
        post :create, :session => @attr
        controller.current_user.should == @user
        controller.should be_signed_in
      end

      it "should redirect to the user show page" do
        post :create, :session => @attr
        response.should redirect_to(user_path(@user))
      end
    end

    
    describe "DELETE 'destroy'" do

      it "should sign a user out" do
        test_sign_in(Factory(:user))
        delete :destroy
        controller.should_not be_signed_in
        response.should redirect_to(root_path)
      end
    end
       
  end
end
