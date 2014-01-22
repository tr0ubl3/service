class SessionsController < ApplicationController
	
	layout 'user', only: [:new]

	def new
		@login = Login.new
	end

	def create
		login = Login.new(params[:login])
		session[:user_id] = login.authenticate
		redirect_to root_url, notice: "You're logged in"
	end
end
