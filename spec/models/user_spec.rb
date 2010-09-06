require 'spec_helper'

describe User do

  before(:each) do
    @attr = {
      :username => "andresbonilla",
      :password => "foobar",
      :password_confirmation => "foobar"
    }
  end

  it "should create a new instance given valid attributes" do
    User.create!(@attr)
  end
  
  it "should require a username" do
    no_username_user = User.new(@attr.merge(:username => ""))
    no_username_user.should_not be_valid
  end
  
  it "should reject usernames that are too long" do
    long_username = "a" * 51
    long_username_user = User.new(@attr.merge(:username => long_username))
    long_username_user.should_not be_valid
  end
  
  it "should reject usernames that are too short" do
    short_username = "aaa"
    short_username_user = User.new(@attr.merge(:username => short_username))
    short_username_user.should_not be_valid
  end
  
  it "should accept validly formatted usernames" do
    usernames = %w[andresbonilla AJGEkjdns345kljnsg23ALK5J ejkn2kjn349339u9uf39u]
    usernames.each do |username|
      valid_username_user = User.new(@attr.merge(:username => username))
      valid_username_user.should be_valid
    end
  end
  
  it "should reject invalidly formatted usernames" do
    usernames = %w[jbh@jhb fsdf.akb sdffffsd-rfoo]
    usernames.each do |username|
      invalid_username_user = User.new(@attr.merge(:username => username))
      invalid_username_user.should_not be_valid
    end
  end
  
  it "should reject duplicate usernames" do
    # Put a user with given username into the database.
    User.create!(@attr)
    user_with_duplicate_username = User.new(@attr)
    user_with_duplicate_username.should_not be_valid
  end
  
  it "should reject usernames identical up to case" do
    upcased_username = @attr[:username].upcase
    User.create!(@attr.merge(:username => upcased_username))
    user_with_duplicate_username = User.new(@attr)
    user_with_duplicate_username.should_not be_valid
  end
  
  describe "password validations" do

    it "should require a password" do
      User.new(@attr.merge(:password => "", :password_confirmation => "")).
        should_not be_valid
      end

    it "should require a matching password confirmation" do
      User.new(@attr.merge(:password_confirmation => "invalid")).
        should_not be_valid
      end

    it "should reject short passwords" do
      short = "a" * 5
      hash = @attr.merge(:password => short, :password_confirmation => short)
      User.new(hash).should_not be_valid
    end

    it "should reject long passwords" do
      long = "a" * 41
      hash = @attr.merge(:password => long, :password_confirmation => long)
      User.new(hash).should_not be_valid
    end 
  end
  
  describe "password encryption" do

    before(:each) do
      @user = User.create!(@attr)
    end

    it "should have an encrypted password attribute" do
      @user.should respond_to(:encrypted_password)
    end
    
    it "should set the encrypted password" do
      @user.encrypted_password.should_not be_blank
    end
    
    describe "has_password? method" do

      it "should be true if the passwords match" do
        @user.has_password?(@attr[:password]).should be_true
      end    

      it "should be false if the passwords don't match" do
        @user.has_password?("invalid").should be_false
      end 
    end
    
    describe "authenticate method" do

      it "should return nil on email/password mismatch" do
        wrong_password_user = User.authenticate(@attr[:email], "wrongpass")
        wrong_password_user.should be_nil
      end

      it "should return nil for an email address with no user" do
        nonexistent_user = User.authenticate("bar@foo.com", @attr[:password])
        nonexistent_user.should be_nil
      end

      it "should return the user on username/password match" do
        matching_user = User.authenticate(@attr[:username], @attr[:password])
        matching_user.should == @user
      end
    end
    
  end
  
  describe "credential associations" do

    before(:each) do
      @user = User.create(@attr)
      @cred1 = Factory(:credential, :user => @user, :created_at => 1.day.ago)
      @cred2 = Factory(:credential, :user => @user, :created_at => 1.hour.ago)
    end


    it "should have a credentials attribute" do
      @user.should respond_to(:credentials)
    end
    
    it "should destroy associated credentials" do
      @user.destroy
      [@cred1, @cred2].each do |credential|
        Credential.find_by_id(credential.id).should be_nil
      end
    end
    
  end
  
  
end
