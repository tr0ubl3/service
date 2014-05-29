class EventCausesController < ApplicationController
	def index
		@causes = EventCause.order(:cause)

		respond_to do |format|
			format.html
			format.json { render json: @causes.tokens(params[:q]), root: false }
		end
	end
end
