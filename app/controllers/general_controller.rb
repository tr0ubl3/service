class GeneralController < ApplicationController
  
  before_filter :check_auth
  before_filter :check_admin, only: [:control_panel] 

  def index
  	@machines = current_user.firm.machines_structure
  end

  def machine_events
    @machine = Machine.find(params[:machine])
  end

  def control_panel
  end
end