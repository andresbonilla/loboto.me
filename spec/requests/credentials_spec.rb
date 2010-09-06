require 'spec_helper'

describe "Credentials" do
  before(:each) do
    @user = Factory(:user)
  end
  describe "GET /credentials" do
    it "should succeed" do
      get user_credentials_path(@user)
    end
  end
end
