require "spec_helper"

describe ManageUsersController do
	describe "routing" do
	    it "routes to #index" do
	      get("/manage_users").should route_to("manage_users#index")
	    end
	end
end