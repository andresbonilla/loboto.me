require 'spec_helper'

describe CredentialsController do
  render_views
  
  before(:each) do
    @base_title = "Password Bucket"
    @user = Factory(:user, :username => "asjhgsjfhgkjh")
    @attr = {
      :service => "facebook",
      :username => "skjgaslkjfnasdfas",
      :crypted_password => "kjsndkfjnaskdfjn",
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
      @user = test_sign_in(Factory(:user))
    end

    describe "failure" do

      before(:each) do
        @attr = { :service => "", :username => "", :crypted_password => "", :user_id => @user.id }
      end

      it "should not create a credential" do
        lambda do
          post :create, :credential => @attr, :user_id => @user.id
        end.should_not change(Credential, :count)
      end

      it "should render the home page" do
        post :create, :credential => @attr, :user_id => @user.id
        response.should render_template('pages/home')
      end
    end

    # describe "success" do
    # 
    #   before(:each) do
    #     @attr = { :content => "Lorem ipsum" }
    #   end
    # 
    #   it "should create a micropost" do
    #     lambda do
    #       post :create, :micropost => @attr
    #     end.should change(Micropost, :count).by(1)
    #   end
    # 
    #   it "should redirect to the home page" do
    #     post :create, :micropost => @attr
    #     response.should redirect_to(root_path)
    #   end
    # 
    #   it "should have a flash message" do
    #     post :create, :micropost => @attr
    #     flash[:success].should =~ /micropost created/i
    #   end
    # end
  end

end
