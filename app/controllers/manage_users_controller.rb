class ManageUsersController < ApplicationController
	
	def index
		@regular_users = User.where(:admin => false)
		@admin_users = User.where(:admin => true)
	end
end
