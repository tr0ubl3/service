class MachinesController < ApplicationController

	def index
		@machines = Machine.order("machines.id ASC")
	end

	def show
		@machine = Machine.find(params[:id])
	end

	def new
		@machine = Machine.new
	end

	def create
		@machine = Machine.new(params[:machine])
		if @machine.save
			flash[:notice] = "Successfully created machine."
			@machine_hours_debut = HourCounter.new(:machine_id => @machine.id, :machine_hours_age => 0)
			@machine_hours_debut.save
			redirect_to machines_path
		else
			render('new')
		end
	end

	def edit
		@machine = Machine.find(params[:id])
	end 

	def update
		@machine = Machine.find(params[:id])
		respond_to do |format|
			if @machine.update_attributes(params[:machine])
				flash[:notice] = "Successfully updated machine."
				format.html { redirect_to(machine_path, :id => @machine.id) }
			else
				render('edit')
			end
	    end
	end

	def delete
		@machine = Machine.find(params[:id])
	end

	def destroy
		machine = Machine.find(params[:id]).destroy
		flash[:notice] = "Machine permanently deleted !"
		redirect_to(:action => 'list')
	end
end
