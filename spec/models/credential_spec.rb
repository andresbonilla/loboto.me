require 'spec_helper'

describe Credential do
  before(:each) do
    @user = Factory(:user)
    @attr = {
      :service => "facebook",
      :username => "pete@sflgkj.com",
      :password => "sfsuhfiasuflni374ry37tbo347",
    }
  end
  
  it "should create a new instance given valid attributes" do
    @user.credentials.build(@attr)
  end

  describe "user associations" do

    before(:each) do
      @credential = @user.credentials.create(@attr)
    end

    it "should have a user attribute" do
      @credential.should respond_to(:user)
    end

    it "should have the right associated user" do
      @credential.user_id.should == @user.id
      @credential.user.should == @user
    end
    
  end
  
  describe "validations" do

    it "should require a user id" do
      @no_user_id = {
        :service => "facebook",
        :username => "pete@sflgkj.com",
        :password => "asdfasdasg",
      }
      Credential.new(@no_user_id).should_not be_valid
    end

    it "should require nonblank fields" do
      @user.credentials.build(:service => "  ", :username => "   ", :password =>"  ").should_not be_valid
    end

    it "should reject long service names" do
      @user.credentials.build(:service => "a" * 101, :username => "sfasdgsfdgsdfg", :password => "asdvasvadfv").should_not be_valid
    end
    
    describe "password validations" do

      it "should require a password" do
        Credential.new(@attr.merge(:password => "")).
          should_not be_valid
        end

      it "should reject short passwords" do
        short = "a" * 5
        hash = @attr.merge(:password => short)
        Credential.new(hash).should_not be_valid
      end

      it "should reject long passwords" do
        long = "a" * 41
        hash = @attr.merge(:password => long)
        Credential.new(hash).should_not be_valid
      end 
    end
    
  end
  

end
