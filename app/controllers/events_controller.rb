class EventsController < ApplicationController
	
	respond_to :html, :json

	def list
		@events = Event.order("events.id ASC")
	end

	def show
		@event = Event.find(params[:id])
		@me = @event.machines.order("events.id ASC")
	end

	def new
		@event = Event.new
		@machines = Machine.all
	end

	def create
		@event = Event.new(params[:event])
		if @event.save
			flash[:notice] = "Successfully created event."
			redirect_to(:action => 'list')
		else
			render('new')
		end
	end

	def update
		@event = Event.find(params[:id])
		respond_to do |format|
			if @event.update_attributes(params[:event])
				flash[:notice] = "Successfully updated event."
				format.html { redirect_to(:action => 'show', :id => @event.id) }
			else
				render('edit')
			end
	    end
	end

	def delete
		@event = Event.find(params[:id])
	end

	def destroy
		event = Event.find(params[:id]).destroy
		flash[:notice] = "Event permanently deleted !"
		redirect_to(:action => 'list')
	end

	def edit
		@event = Event.find(params[:id])
	end 
end
