class SessionsController < ApplicationController
	
	layout 'user', only: [:new]

	def new
		@login = Login.new
	end

	def create
		login = Login.new(params[:login])
		if login.conditional_authentication
			session[:user_id] = login.conditional_authentication
			redirect_to root_url, notice: "You're logged in"
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
