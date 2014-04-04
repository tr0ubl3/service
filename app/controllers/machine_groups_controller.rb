class MachineGroupsController < ApplicationController
  # GET /machine_groups
  # GET /machine_groups.json
  def index
    @machine_groups = MachineGroup.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @machine_groups }
    end
  end

  # GET /machine_groups/1
  # GET /machine_groups/1.json
  def show
    @machine_group = MachineGroup.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @machine_group }
    end
  end

  # GET /machine_groups/new
  # GET /machine_groups/new.json
  def new
    @machine_group = MachineGroup.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @machine_group }
    end
  end

  # GET /machine_groups/1/edit
  def edit
    @machine_group = MachineGroup.find(params[:id])
  end

  # POST /machine_groups
  # POST /machine_groups.json
  def create
    @machine_group = MachineGroup.new(params[:machine_group])

    respond_to do |format|
      if @machine_group.save
        format.html { redirect_to @machine_group, notice: 'Machine group was successfully created.' }
        format.json { render json: @machine_group, status: :created, location: @machine_group }
      else
        format.html { render action: "new" }
        format.json { render json: @machine_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /machine_groups/1
  # PUT /machine_groups/1.json
  def update
    @machine_group = MachineGroup.find(params[:id])

    respond_to do |format|
      if @machine_group.update_attributes(params[:machine_group])
        format.html { redirect_to @machine_group, notice: 'Machine group was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @machine_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /machine_groups/1
  # DELETE /machine_groups/1.json
  def destroy
    @machine_group = MachineGroup.find(params[:id])
    @machine_group.destroy

    respond_to do |format|
      format.html { redirect_to machine_groups_url }
      format.json { head :no_content }
    end
  end
end
