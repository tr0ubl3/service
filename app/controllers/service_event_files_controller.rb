class ServiceEventFilesController < ApplicationController

	def create
		@event = ServiceEvent.find(params[:service_event_id])
	    @file = @event.service_event_files.build(params[:file])
	    respond_to do |format|
	      if @file.save
	        format.json { render json: @file, status: :created, location: @file }
	      else
	        format.json { render json: @file.errors, status: :unprocessable_entity }
	      end
	    end
	end
end