class MachinesController < ApplicationController
helper_method :manufacturers, :owners, :machine_manufacturer, :manufacturer_test?	
	def list
		@machines = Machine.order("machines.id ASC")
	end

	def new
		@machine = Machine.new
	end

	def create
		@machine = Machine.new(params[:machine])
		if @machine.save
			flash[:notice] = "Successfully created machine."
			redirect_to(:action => 'list')
		else
			render('new')
		end
	end

	def manufacturers
	 	@manufacturers ||= Manufacturer.all
	end

	def owners
		@owners ||= MachineOwner.all
	end
end
