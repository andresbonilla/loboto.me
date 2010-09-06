require "spec_helper"

describe CredentialsController do
  describe "routing" do

    it "recognizes and generates #new" do
      { :get => "/users/3/credentials/new" }.should route_to(:controller => "credentials", :action => "new", :user_id => "3")
    end

    it "recognizes and generates #show" do
      { :get => "/users/3/credentials/1" }.should route_to(:controller => "credentials", :action => "show", :id => "1", :user_id => "3")
    end

    it "recognizes and generates #edit" do
      { :get => "/users/3/credentials/1/edit" }.should route_to(:controller => "credentials", :action => "edit", :id => "1", :user_id => "3")
    end

    it "recognizes and generates #create" do
      { :post => "/users/3/credentials" }.should route_to(:controller => "credentials", :action => "create", :user_id => "3")
    end

    it "recognizes and generates #update" do
      { :put => "/users/3/credentials/1" }.should route_to(:controller => "credentials", :action => "update", :id => "1", :user_id => "3")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/users/3/credentials/1" }.should route_to(:controller => "credentials", :action => "destroy", :id => "1", :user_id => "3")
    end

  end
end
