class SessionsController < ApplicationController
	
	layout 'user', only: [:new]

	def new
		@login = Login.new
	end

	def create
		login = Login.new(params[:login])
		if login.authenticate
			session[:user_id] = login.authenticate
			redirect_to root_url, notice: "You're logged in"
		else
			redirect_to login_path, alert: 'Invalid email or password'
		end
	end
end
