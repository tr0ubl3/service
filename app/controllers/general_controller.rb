class GeneralController < ApplicationController
  before_filter :authenticate_user!
  def index
	@machines = Machine.where(:machine_owner_id => current_user.machine_owner)
	@manufacturers = []
	@machines.each do |m|
		@manufacturers << m.manufacturer.name
	end
	@manufacturers.uniq.each do |t|
		@man_machines = Manufacturer.where(:name => t).first.machines
	end
  end
end
