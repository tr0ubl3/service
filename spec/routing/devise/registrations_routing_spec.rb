require "spec_helper"

describe Devise::RegistrationsController do
  describe "routing" do

    it "routes to #index" do
      get("/devise/registrations").should route_to("devise/registrations#index")
    end

    it "routes to #new" do
      get("/devise/registrations/new").should route_to("devise/registrations#new")
    end

    it "routes to #show" do
      get("/devise/registrations/1").should route_to("devise/registrations#show", :id => "1")
    end

    it "routes to #edit" do
      get("/devise/registrations/1/edit").should route_to("devise/registrations#edit", :id => "1")
    end

    it "routes to #create" do
      post("/devise/registrations").should route_to("devise/registrations#create")
    end

    it "routes to #update" do
      put("/devise/registrations/1").should route_to("devise/registrations#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/devise/registrations/1").should route_to("devise/registrations#destroy", :id => "1")
    end

  end
end
