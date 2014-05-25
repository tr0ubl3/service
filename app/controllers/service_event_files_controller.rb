class ServiceEventFilesController < ApplicationController

	before_filter :check_auth
	before_filter :check_admin

	def create
	    @file = ServiceEventFile.new(params[:service_event_file])
	    respond_to do |format|
	      if @file.save
	        format.json { render json: @file, status: :created, location: @file }
	      else
	        format.json { render json: @file.errors, status: :unprocessable_entity }
	      end
	    end
	end
end