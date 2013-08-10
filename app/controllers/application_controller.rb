class ApplicationController < ActionController::Base
  protect_from_forgery

  	def index
		list
    	render('list')
	end
end
