class MachineOwnersController < ApplicationController
	respond_to :html, :json

	def list
		@owners = MachineOwner.order("firms.id ASC")
	end

	def show
		@owner = MachineOwner.find(params[:id])
		# mm = machine manufacturer = machine owner
		@mm = @owner.machines.order("machines.id ASC")
	end

	def new
		@owner = MachineOwner.new
	end

	def create
		@owner = MachineOwner.new(params[:machine_owner])
		if @owner.save
			flash[:notice] = "Successfully created machine owner."
			redirect_to(:action => 'list')
		else
			render('new')
		end
	end

	def update
		@owner = MachineOwner.find(params[:id])
		respond_to do |format|
			if @owner.update_attributes(params[:machine_owner])
				flash[:notice] = "Successfully updated machine owner."
				format.html { redirect_to(:action => 'show', :id => @owner.id) }
			else
				render('edit')
			end
	    end
	end

	def delete
		@owner = MachineOwner.find(params[:id])
	end

	def destroy
		owner = MachineOwner.find(params[:id]).destroy
		flash[:notice] = "Machine owner permanently deleted !"
		redirect_to(:action => 'list')
	end

	def edit
		@owner = MachineOwner.find(params[:id])
	end 
end
