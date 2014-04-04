class GeneralController < ApplicationController
  
  before_filter :check_auth
  before_filter :check_admin, only: [:control_panel] 

  def index
  	@machines = current_user.firm.machines
    @manufacturer_names = @machines.collect(&:manufacturer).collect(&:name)
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