class SessionsController < ApplicationController
	
	layout 'user', only: [:new]

	def new
		@login = Login.new
	end

	def create
		login = Login.new(params[:login])
		if login.conditional_authentication
			session[:user_id] = login.conditional_authentication
			update_login_count(current_user)
			flash[:notice] = "You're logged in"
			redirect_back
		else
			redirect_to login_path, alert: 'Invalid email or password'
		end
	end

	def destroy
		session[:user_id] = nil
		redirect_to login_path
		flash[:notice] = "You are logged out!"
	end
end
