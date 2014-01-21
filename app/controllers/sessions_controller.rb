class SessionsController < ApplicationController
	
	layout 'user', only: [:new]

	def new
		@login = Login.new
	end

	def create
		login = Login.new(params[:login])
		login.authenticate
		render nothing: true
	end
end
