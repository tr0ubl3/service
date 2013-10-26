class ApplicationController < ActionController::Base
  protect_from_forgery

  	def index
		list
    	render('list')
	end
	layout :layout

	private
	def layout
		if devise_controller?
		      "user"
		    else
		      "application"
	    end
	end
end
