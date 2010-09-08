require 'spec_helper'

describe UsersController do
  render_views
  
  before(:each) do
    @base_title = "Password Bucket"
  end
  
  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end
    
    it "should have the right title" do
      get 'new'
      response.should have_selector("title", :content => @base_title + " | Sign up")
    end
    
  end


  describe "POST 'create'" do

    describe "failure" do
      before(:each) do
        @attr = { :username => "", :password => "", :password_confirmation => "" }
      end

      it "should not create a user" do
        lambda do
          post :create, :user => @attr
        end.should_not change(User, :count)
      end

      it "should render the 'new' page" do
        post :create, :user => @attr
        response.should render_template('new')
      end
    end
  
    describe "success" do

      before(:each) do
        @attr = { :username => "whatev", :password => "askuv73br78", :password_confirmation => "askuv73br78" }
      end

      it "should create a user" do
        lambda do
          post :create, :user => @attr
        end.should change(User, :count).by(1)
      end

      it "should redirect to the user show page" do
        post :create, :user => @attr
        response.should redirect_to(user_path(assigns(:user)))
      end    
    end    
  end
  
  describe "authentication of profile pages" do

    before(:each) do
      @user = Factory(:user)
    end

    describe "for non-signed-in users" do
      it "should deny access to 'show'" do
        get :show, :id => @user
        response.should redirect_to(signin_path)
      end
    end
    
    describe "for signed-in users" do
      it "should be successful" do
        test_sign_in(@user)
        get :show, :id => @user
        response.should be_success
      end
      
      it "should show the user's credentials" do
        test_sign_in(@user)
        cred1 = Factory(:credential, :user => @user, :service => "Foo bar", :password => "sdfb$%$kn84n3i84f")
        cred2 = Factory(:credential, :user => @user, :service => "Baz quux", :password => "sdfb$%$kn84n3i84f")
        get :show, :id => @user
        response.should have_selector("td", :content => cred1.service)
        response.should have_selector("td", :content => cred2.service)
      end
      
      it "should have the right title" do
        test_sign_in(@user)
        get :show, :id => @user
        response.should have_selector("title", :content => @base_title + " | " + @user.username)
      end
      
      it "should find the right user" do
        test_sign_in(@user)
        get :show, :id => @user
        assigns(:user).should == @user
      end
      
      it "should require matching user for 'show'" do
        wrong_user = Factory(:user, :username => "asjhgsjfhgkjh")
        test_sign_in(wrong_user)
        get :show, :id => @user
        response.should redirect_to(root_path)
      end
    end
    
  end
  
  
end
