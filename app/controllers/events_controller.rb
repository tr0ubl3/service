class EventsController < ApplicationController
	
	respond_to :html, :json

	# def list
	# 	@events = Event.order("events.id ASC")
	# end

	# def show
	# 	@event = Event.find(params[:id])
	# 	@me = @event.machines.order("events.id ASC")
	# end

	def new
		@event = Event.new
		@machines = Machine.all
		@alarm_search = Alarm.t1(params[:search])
		@a = Alarm.find(1)
		respond_to do |format|
			format.html
			format.json { render json: @alarm_search }
		end

	end

	def create
		@event = Event.new(params[:event])
		if @event.save
			if :alarms != nil
				@event.alarms << Alarm.find(params[:alarms])
			end
			redirect_to root_url
			flash[:notice] = 'Event succesfully registered!'	
		else
			flash.now[:alert] = 'Please correct errors and try again!'
			render 'events/new'
		end
	end

	# def update
	# 	@event = Event.find(params[:id])
	# 	respond_to do |format|
	# 		if @event.update_attributes(params[:event])
	# 			flash[:notice] = "Successfully updated event."
	# 			format.html { redirect_to(:action => 'show', :id => @event.id) }
	# 		else
	# 			render('edit')
	# 		end
	#     end
	# end

	# def delete
	# 	@event = Event.find(params[:id])
	# end

	# def destroy
	# 	event = Event.find(params[:id]).destroy
	# 	flash[:notice] = "Event permanently deleted !"
	# 	redirect_to(:action => 'list')
	# end

	# def edit
	# 	@event = Event.find(params[:id])
	# end 
end