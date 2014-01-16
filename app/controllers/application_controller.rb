class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :user_full_name, :check_user_admin?
  # before_filter :check_user_admin?

  	def index
		list
    	render('list')
	end
	
	layout 'application'

	private
		def check_user_admin?
			if current_user.admin == true
				new_events_count
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
