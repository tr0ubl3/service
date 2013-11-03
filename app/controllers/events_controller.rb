class EventsController < ApplicationController
	
	respond_to :html, :json
	before_filter :authenticate_user!

	def list
		@events = Event.order("events.id DESC")
	end

	# def show
	# 	@event = Event.find(params[:id])
	# 	@me = @event.machines.order("events.id ASC")
	# end

	def new
		@event = Event.new
		@machines = Machine.where(:machine_owner_id => current_user.machine_owner)
		@alarm_search = Alarm.t1(params[:search])
		# @a = Alarm.find(1)
		respond_to do |format|
			format.html
			format.json { render json: @alarm_search }
		end

	end

	def create
		@event = Event.new(params[:event])
		@event.user_id = current_user.id
		# hc = hour counter
		@hc = HourCounter.find_by_machine_id(@event.machine_id)
		if @event.save
			if params[:alarms] != nil
				@event.alarms << Alarm.find(params[:alarms])
			end
			@machine = Machine.find(@event.machine_id)
			@manufacturer = @machine.manufacturer.name.upcase.first(limit=3)
			@machine_number = @machine.machine_number.gsub(/[-]/i, '')
			@event_time = @event.created_at.strftime('%d%m%y%H%M%S')
			@event_count = "%.5d" % @machine.events.count
			@owner = @machine.machine_owner.name.upcase.first(limit=3)
			@event_name = @manufacturer + '-'+ @machine_number + '-' + @event_time + '-' + @event_count + '-' + @owner
			@event.update_attributes(:event_name => @event_name)
			@hc.update_attributes(:machine_hours_age => @event.hour_counter)
			# EventNotifier.confirmation(@event, @machine).deliver
			# EventNotifier.notification(@event, @machine).deliver
			flash[:notice] = 'Event ' + @event_name + ' registered!' 	
			render :action => 'confirmation'
		else
			@machines = Machine.where(:machine_owner_id => current_user.machine_owner)
			flash.now[:alert] = 'Please correct errors and try again!'
			render :action => 'new'
		end
	end

	def confirmation
		@event_name = @event.event_name
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