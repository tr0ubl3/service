class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :user_full_name
  before_filter :new_events_count

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

		def new_events_count
			@new_events = ServiceEvent.where(:state => 'pending_confirmation').count
			if @new_events > 0
				@new_events
			else
				@new_events = nil
			end

		end

	protected
		def user_full_name(id)
			User.find(id).full_name
		end
end
