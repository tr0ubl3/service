class ServiceEventsController < ApplicationController
	respond_to :html, :json

	def index
		@events = ServiceEvent.order("service_events.id DESC")
	end

	def show
		@event = ServiceEvent.find(params[:id])
	end

	def new
		@event = ServiceEvent.new
		# @alarm_search = Alarm.search(params[:search])
		# if params[:machine] != nil
		# 	params[:machine_id] = params[:machine]
		# 	@machine_display_name = Machine.find_by_id(params[:machine]).display_name
		# end

		respond_to do |format|
			format.html
			format.json { render json: Alarm.search(params[:search]) }
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
			# ServiceEventNotifier.confirmation(@event, @machine).deliver
			# ServiceEventNotifier.notification(@event, @machine).deliver
			flash[:notice] = 'Event ' + @event_name + ' registered!' 	
			redirect_to root_path
		else
			@machines = Machine.where(:machine_owner_id => current_user.firm_id)
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
		@machines = Machine.where(:machine_owner_id => current_user.machine_owner)
		@machine_display_name = @machines.find(@event.machine_id).display_name
		@hc = HourCounter.find_by_machine_id(@event.machine_id).machine_hours_age
	end 
	
	def update
		@event = ServiceEvent.find(params[:id])
		@machines = Machine.where(:machine_owner_id => current_user.machine_owner)
		@machine_display_name = @machines.find(@event.machine_id).display_name
		@hc = HourCounter.find_by_machine_id(@event.machine_id)
		respond_to do |format|
			if @event.update_attributes(params[:service_event])
				if params[:alarms] != nil
					# entered alarms difference
					@new_alarms = params[:alarms].map(&:to_i) - @event.alarm_ids
					@event.alarms << Alarm.find(@new_alarms)
					# deleted alarms diference
					@deleted_alarms = @event.alarm_ids - params[:alarms].map(&:to_i)
					@deleted_alarms.each do |obj|
						@event.alarms.delete Alarm.find(obj)
					end
				else
					@event.alarms.delete_all
				end
				if params[:hour_counter].to_i != @hc
					@hc.update_attributes(:machine_hours_age => params[:hour_counter].to_i)
				end
				@event.unconfirmed
				flash[:notice] = "Successfully updated event."
				format.html { redirect_to service_event_path(@event) }
			else
				flash[:alert] = "Please corect errors and try again"
				redirect_to edit_service_event_path(@event), :method => :get
			end
	    end
	end
	
	private
	def check_event_confirmation(id)
		@audit_event = ServiceEventStateTransition.where(:service_event_id => id).where(to:['confirmed', 'revised_event'])
		if @audit_event.blank?
			true
		else
			@class = 'disabled'
			@title = 'Event is already confirmed'
			@confirm_event_link ='#'
			@confirm_event_confirmation = nil
		end
	end


	# def delete
	# 	@event = ServiceEvent.find(params[:id])
	# end

	# def destroy
	# 	event = ServiceEvent.find(params[:id]).destroy
	# 	flash[:notice] = "Event permanently deleted !"
	# 	redirect_to(:action => 'list')
	# end

end