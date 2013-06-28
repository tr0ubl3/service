class ManufacturersController < ApplicationController

	def list
		@manufacturers = Manufacturer.order("manufacturers.id ASC")
	end

	def show
		@manufacturer = Manufacturer.find(params[:id])
	end
end
