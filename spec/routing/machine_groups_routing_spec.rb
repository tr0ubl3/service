require "spec_helper"

describe MachineGroupsController do
  describe "routing" do

    it "routes to #index" do
      get("/machine_groups").should route_to("machine_groups#index")
    end

    it "routes to #new" do
      get("/machine_groups/new").should route_to("machine_groups#new")
    end

    it "routes to #show" do
      get("/machine_groups/1").should route_to("machine_groups#show", :id => "1")
    end

    it "routes to #edit" do
      get("/machine_groups/1/edit").should route_to("machine_groups#edit", :id => "1")
    end

    it "routes to #create" do
      post("/machine_groups").should route_to("machine_groups#create")
    end

    it "routes to #update" do
      put("/machine_groups/1").should route_to("machine_groups#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/machine_groups/1").should route_to("machine_groups#destroy", :id => "1")
    end

  end
end
