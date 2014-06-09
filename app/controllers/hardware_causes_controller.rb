class HardwareCausesController < ApplicationController
	
	def index
		@causes = HardwareCause.order(:name)

		respond_to do |format|
			format.html
			format.json { render json: @causes.tokens(params[:q]), root: false }
		end
	end

	def show
		@cause = HardwareCause.find(params[:id])

		respond_to do |format|
			format.json { render json: @cause, root: false }
		end
	end
end