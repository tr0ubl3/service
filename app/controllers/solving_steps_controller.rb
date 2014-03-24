class SolvingStepsController < ApplicationController
  # GET /solving_steps
  # GET /solving_steps.json
  def index
    @solving_steps = SolvingStep.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @solving_steps }
    end
  end

  # # GET /solving_steps/1
  # # GET /solving_steps/1.json
  # def show
  #   @solving_step = SolvingStep.find(params[:id])

  #   respond_to do |format|
  #     # format.html # show.html.erb
  #     format.json { render json: @solving_step }
  #   end
  # end

  # # GET /solving_steps/new
  # # GET /solving_steps/new.json
  # def new
  #   @solving_step = SolvingStep.new

  #   respond_to do |format|
  #     # format.html # new.html.erb
  #     format.json { render json: @solving_step }
  #   end
  # end

  # # GET /solving_steps/1/edit
  # def edit
  #   @solving_step = SolvingStep.find(params[:id])
  # end

  # # POST /solving_steps
  # # POST /solving_steps.json
  def create
    @solving_step = SolvingStep.new(params[:solving_step])

    respond_to do |format|
      if @solving_step.save
        # format.html { redirect_to @solving_step, notice: 'Solving step was successfully created.' }
        format.json { render json: @solving_step, status: :created, location: @solving_step }
      else
        # format.html { render action: "new" }
        format.json { render json: @solving_step.errors, status: :unprocessable_entity }
      end
    end
  end

  # # PUT /solving_steps/1
  # # PUT /solving_steps/1.json
  # def update
  #   @solving_step = SolvingStep.find(params[:id])

  #   respond_to do |format|
  #     if @solving_step.update_attributes(params[:solving_step])
  #       # format.html { redirect_to @solving_step, notice: 'Solving step was successfully updated.' }
  #       format.json { head :no_content }
  #     else
  #       # format.html { render action: "edit" }
  #       format.json { render json: @solving_step.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # # DELETE /solving_steps/1
  # # DELETE /solving_steps/1.json
  # def destroy
  #   @solving_step = SolvingStep.find(params[:id])
  #   @solving_step.destroy

  #   respond_to do |format|
  #     # format.html { redirect_to solving_steps_url }
  #     format.json { head :no_content }
  #   end
  # end
end