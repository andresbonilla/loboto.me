require "spec_helper"

describe CredentialsController do
  describe "routing" do

        it "recognizes and generates #index" do
      { :get => "/credentials" }.should route_to(:controller => "credentials", :action => "index")
    end

        it "recognizes and generates #new" do
      { :get => "/credentials/new" }.should route_to(:controller => "credentials", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/credentials/1" }.should route_to(:controller => "credentials", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/credentials/1/edit" }.should route_to(:controller => "credentials", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/credentials" }.should route_to(:controller => "credentials", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/credentials/1" }.should route_to(:controller => "credentials", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/credentials/1" }.should route_to(:controller => "credentials", :action => "destroy", :id => "1")
    end

  end
end
