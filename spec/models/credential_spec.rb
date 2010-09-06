require 'spec_helper'

describe Credential do
  before(:each) do
    @user = Factory(:user)
    @attr = {
      :service => "facebook",
      :username => "pete@sflgkj.com",
      :crypted_password => "sfsuhfiasuflni374ry37tbo347",
      :user_id => @user.id
    }
  end

  it "should create a new instance given valid attributes" do
    @user.credentials.create!(@attr)
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
        :crypted_password => "sfsuhfiasuflni374ry37tbo347",
      }
      Credential.new(@no_user_id).should_not be_valid
    end

    it "should require nonblank fields" do
      @user.credentials.build(:service => "  ", :username => "   ", :crypted_password => "   ").should_not be_valid
    end

    it "should reject long service names" do
      @user.credentials.build(:service => "a" * 101, :username => "sfasdgsfdgsdfg", :crypted_password => "sdfgsdfgdsfg" ).should_not be_valid
    end
    
  end
  

end
