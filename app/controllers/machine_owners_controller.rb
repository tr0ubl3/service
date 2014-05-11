class MachineOwnersController < ApplicationController

	before_filter :check_auth
	before_filter :check_admin

	def index
		@owners = MachineOwner.order("firms.id ASC")
		respond_to do |format|
			format.html
			format.json { render json: MachineOwnerJdts.new(view_context) }
		end
	end

	def show
		@owner = MachineOwner.find(params[:id])
		# mm = machine manufacturer = machine owner
		# @mm = @owner.machines.order("machines.id ASC")
		respond_to do |format|
	      format.html
	      format.json { render json: @owner }
	    end
	end

	def new
		@owner = MachineOwner.new
		
		respond_to do |format|
			format.html # new.html.erb
			format.js { render :layout => false }
		end
	end

	def create
		@owner = MachineOwner.new(params[:machine_owner])
		respond_to do |format|
			if @owner.save
				format.html {
					flash[:notice] = "Successfully created machine owner."
					redirect_to machine_owners_path
				}
				format.js { render nothing: true, status: :created, location: @owner }
			else
				format.html { 
					flash.now[:error] = "Please correct errors and try again!"
					render :new
				}
				format.js { render :new, :layout => false, status: :unprocessable_entity }
			end
		end
	end

	def update
		@owner = MachineOwner.find(params[:id])
		respond_to do |format|
			if @owner.update_attributes(params[:machine_owner])
				format.html { 
					flash[:notice] = "Successfully updated machine owner."
					redirect_to(machine_owner_path, :id => @owner.id)
				}
				format.js { head :no_content }
			else
				format.html { 
					flash.now[:error] = "Please correct errors and try again!"
					render :edit
				}
				format.js { render :edit, :layout => false, status: :unprocessable_entity }
			end
	    end
	end

	def delete
		@owner = MachineOwner.find(params[:id])
	end

	def destroy
		owner = MachineOwner.find(params[:id]).destroy
		flash[:notice] = "Machine owner permanently deleted !"
		redirect_to machine_owners_path
	end

	def edit
		@owner = MachineOwner.find(params[:id])

		respond_to do |format|
			format.html # new.html.erb
			format.js { render :layout => false }
		end
	end 
end
