class ServiceEventsController < ApplicationController
	
	respond_to :html, :json
	before_filter :authenticate_user!

	def list
		@events = ServiceEvent.order("service_events.id DESC")
	end

	def show
		@event = ServiceEvent.find(params[:id])
		@confirm_event_link = confirm_event_service_events_path(:id => params[:id])
		@confirm_event_confirmation = "Are you sure you want to confirm this event ?"
		check_event_confirmation(@event)
		@machine_owner = Firm.find(Machine.find(@event.machine_id).machine_owner_id)
		@event_user = User.find(@event.user_id)
		@machine = Machine.find(@event.machine_id)
		@hour_counter = Machine.find(@event.machine_id).hour_counter.machine_hours_age
		if @event.event_type = 1
				@event_type_text = 'Machine fully stopped'
			elsif @event.event_type = 2
				@event_type_text = 'Machine was working with problems'
			elsif @event.event_type = 3
				@event_type_text = 'Event unrelated to machine stopping'
		end
		# @me = @event.machines.order("events.id ASC")
	end

	def new
		@event = ServiceEvent.new
		@machines = Machine.where(:machine_owner_id => current_user.machine_owner)
		@alarm_search = Alarm.t1(params[:search])
		if params[:machine] != nil
			params[:machine_id] = params[:machine]
			@machine_display_name = " for " + @machines.where(:id => params[:machine]).first.display_name
		end

		# @a = Alarm.find(1)
		respond_to do |format|
			format.html
			format.json { render json: @alarm_search }
		end

	end

	def create
		@event = ServiceEvent.new(params[:event])
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
			@event_count = "%.5d" % @machine.service_events.count
			@owner = @machine.machine_owner.name.upcase.first(limit=3)
			@event_name = @manufacturer + '-'+ @machine_number + '-' + @event_time + '-' + @event_count + '-' + @owner
			@event.update_attributes(:event_name => @event_name)
			@hc.update_attributes(:machine_hours_age => @event.hour_counter)
			@event.confirmation
			# EventNotifier.confirmation(@event, @machine).deliver
			# EventNotifier.notification(@event, @machine).deliver
			flash[:notice] = 'Event ' + @event_name + ' registered!' 	
			redirect_to root_path
		else
			@machines = Machine.where(:machine_owner_id => current_user.machine_owner)
			flash.now[:alert] = 'Please correct errors and try again!'
			render :new
		end
	end

	def confirmation
		@event_name = @event.event_name
	end

	def confirm_event
		@event = ServiceEvent.find(params[:id])
		if check_event_confirmation(@event) == true
			@event.confirmed
			flash[:notice] = 'Event is confirmed'
			redirect_to service_event_path(@event)
		else
			flash[:notice] = "Something went wrong"
		end
			
	end

	def edit
		@event = ServiceEvent.find(params[:id])
	end 
	
	private

	def check_event_confirmation(id)
		@audit_event = ServiceEventStateTransition.where(:service_event_id => id).where(:to => 'confirmed')
		if @audit_event.blank?
			true
		else
			@class = 'disabled'
			@title = 'Event is already confirmed'
			@confirm_event_link ='#'
			@confirm_event_confirmation = nil
		end

	end

	# def update
	# 	@event = ServiceEvent.find(params[:id])
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
	# 	@event = ServiceEvent.find(params[:id])
	# end

	# def destroy
	# 	event = ServiceEvent.find(params[:id]).destroy
	# 	flash[:notice] = "Event permanently deleted !"
	# 	redirect_to(:action => 'list')
	# end

end