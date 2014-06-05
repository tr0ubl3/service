class EventCausesController < ApplicationController
	def index
		@causes = EventCause.order(:name)

		respond_to do |format|
			format.html
			format.json { render json: @causes.tokens(params[:q]), root: false }
		end
	end

	def show
		@cause = EventCause.find(params[:id])

		respond_to do |format|
			format.json { render json: @cause, root: false }
		end

	end
end
