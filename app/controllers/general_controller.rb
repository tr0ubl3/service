class GeneralController < ApplicationController
  
  before_filter :check_auth

  def index
  	@machines = MachineOwner.find(current_user.machine_owner_id).machines
    @manufacturer_names = @machines.collect(&:manufacturer).uniq.collect(&:name)
    
  end

  def machine_events
    @machine_name = Machine.find(params[:machine]).display_name
    @machine_events_all = ServiceEvent.where(:machine_id => params[:machine])
    @machine_user_events = @machine_events_all.where(:user_id => current_user)
    @row_number_tab1 = 0
    @row_number_tab2 = 0
  end

  def control_panel
  end
end

def machine_types(manufacturer_name)
  @machines.where(:manufacturer_id => Manufacturer.find_by_name(manufacturer_name).id).collect(&:machine_type).uniq
end

def machines_collection(manufacturer_name, machine_type)
  @machines.where(:manufacturer_id => Manufacturer.find_by_name(manufacturer_name).id,
                  :machine_type => machine_type)
end