require "spec_helper"

describe SolvingStepsController do
  describe "routing" do

    it "routes to #index" do
      get("/solving_steps").should route_to("solving_steps#index")
    end

    it "routes to #new" do
      get("/solving_steps/new").should route_to("solving_steps#new")
    end

    it "routes to #show" do
      get("/solving_steps/1").should route_to("solving_steps#show", :id => "1")
    end

    it "routes to #edit" do
      get("/solving_steps/1/edit").should route_to("solving_steps#edit", :id => "1")
    end

    it "routes to #create" do
      post("/solving_steps").should route_to("solving_steps#create")
    end

    it "routes to #update" do
      put("/solving_steps/1").should route_to("solving_steps#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/solving_steps/1").should route_to("solving_steps#destroy", :id => "1")
    end

  end
end
