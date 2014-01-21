class SessionsController < ApplicationController
	
	layout 'user', only: [:new]

	def new
		@login = Login.new
	end
end
