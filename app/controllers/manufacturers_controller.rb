class ManufacturersController < ApplicationController

	respond_to :html, :json

	def list
		@manufacturers = Manufacturer.order("firms.id ASC")
	end

	def show
		@manufacturer = Manufacturer.find(params[:id])
		@mm = @manufacturer.machines.order("machines.id ASC")
	end

	def new
		@manufacturer = Manufacturer.new
	end

	def create
		@manufacturer = Manufacturer.new(params[:manufacturer])
		if @manufacturer.save
			flash[:notice] = "Successfully created manufacturer."
			redirect_to(:action => 'list')
		else
			render('new')
		end
	end

	def update
		@manufacturer = Manufacturer.find(params[:id])
		respond_to do |format|
			if @manufacturer.update_attributes(params[:manufacturer])
				flash[:notice] = "Successfully updated manufacturer."
				format.html { redirect_to(:action => 'show', :id => @manufacturer.id) }
			else
				render('edit')
			end
	    end
	end

	def delete
		@manufacturer = Manufacturer.find(params[:id])
	end

	def destroy
		manufacturer = Manufacturer.find(params[:id]).destroy
		flash[:notice] = "Manufacturer permanently deleted !"
		redirect_to(:action => 'list')
	end

	def edit
		@manufacturer = Manufacturer.find(params[:id])
	end 
end
