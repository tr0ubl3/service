class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :user_full_name

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

	protected
		def user_full_name(id)
			User.find(id).full_name
		end
end
