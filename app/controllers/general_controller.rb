class GeneralController < ApplicationController
  before_filter :authenticate_user!
  helper_method :user_full_name
  def index
	@manufacturer_ids = Machine.owner_manufacturer_ids(current_user.machine_owner)
	# @manufacturer_ids.each do |id|
	# 	@manufacturer_names = Machine.owner_manufacturer_name(id)
	# 	@manufacturer_machine_types = Machine.manufacturer_machine_types(id)
	# 	@manufacturer_machine_types.each do |type|
	# 		@machines = Machine.owner_machines_by_manufacturer_and_type(params[current_user.machine_owner, id, type])
	# 	end
	# end
	# @machines = Machine.where(:machine_owner_id => current_user.machine_owner)
	# @machine_manufacturer_ids = @machines.select(:manufacturer_id).map(&:manufacturer_id).uniq
	# @manufacturer_names = Manufacturer.where(:id => @machine_manufacturer_ids).select(:name).map(&:name)
	# @machine_type = @machines.where().select(:machine_type).map(&:machine_type).map(&:upcase).uniq
	# @manufacturers = []
	# @machines.each do |m|
	# 	@manufacturers << m.manufacturer.name
	# end
	# @manufacturers.uniq.each do |t|
	# 	@man_machines = Manufacturer.where(:name => t).first.machines
	# end
  end

  def machine_events
  	@machine_name = Machine.find(params[:machine]).display_name
	@machine_events_all = Event.where(:machine_id => params[:machine])
	@machine_user_events = @machine_events_all.where(:user_id => current_user)
	@row_number_tab1 = 0
	@row_number_tab2 = 0

	def user_full_name(id)
		User.find(id).full_name
	end
  end
end
