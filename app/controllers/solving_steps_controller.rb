class SolvingStepsController < ApplicationController
  before_filter :check_auth
  before_filter :check_admin
  def index
    @solving_steps = SolvingStep.where(:service_event_id => params[:service_event_id])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @solving_steps }
    end
  end

  def show
    @solving_step = SolvingStep.find(params[:id])
    respond_to do |format|
      # format.html # show.html.erb
      format.json { render json: @solving_step }
    end
  end

  def create
    @solving_step = SolvingStep.new(params[:solving_step])
    @solving_step.user_id = session[:user_id]
    
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

  def update
    @solving_step = SolvingStep.find(params[:id])

    respond_to do |format|
      if @solving_step.update_attributes(params[:solving_step])
        # format.html { redirect_to @solving_step, notice: 'Solving step was successfully updated.' }
        format.json { head :no_content }
      else
        # format.html { render action: "edit" }
        format.json { render json: @solving_step.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @solving_step = SolvingStep.find(params[:id])
    @solving_step.destroy

    respond_to do |format|
      format.html { redirect_to solving_steps_url }
      format.json { head :no_content }
    end
  end
end