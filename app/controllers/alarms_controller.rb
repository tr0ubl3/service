class AlarmsController < ApplicationController
  
  def index
    @alarms = Alarm.all
  end

  # GET /alarms/1
  # GET /alarms/1.json
  def show
    @alarm = Alarm.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @alarm }
    end
  end

  # GET /alarms/new
  # GET /alarms/new.json
  def new
    @machine_group = MachineGroup.find(params[:machine_group_id])
    @alarm = @machine_group.alarms.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @alarm }
    end
  end

  # GET /alarms/1/edit
  def edit
    @alarm = Alarm.find(params[:id])
  end

  # POST /alarms
  # POST /alarms.json
  def create
    @machine_group = MachineGroup.find(params[:machine_group_id])
    @alarm = @machine_group.alarms.build(params[:alarm])
    respond_to do |format|
      if @alarm.save
        format.html { redirect_to @alarm, notice: 'Alarm was successfully created.' }
        format.json { render json: @alarm, status: :created, location: @alarm }
      else
        format.html { render action: "new" }
        format.json { render json: @alarm.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /alarms/1
  # PUT /alarms/1.json
  def update
    @alarm = Alarm.find(params[:id])

    respond_to do |format|
      if @alarm.update_attributes(params[:alarm])
        format.html { redirect_to @alarm, notice: 'Alarm was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @alarm.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /alarms/1
  # DELETE /alarms/1.json
  def destroy
    @alarm = Alarm.find(params[:id])
    @alarm.destroy

    respond_to do |format|
      format.html { redirect_to alarms_url }
      format.json { head :no_content }
    end
  end

  def import
    Alarm.import(params[:file])
    redirect_to alarms_path, notice: "Alarms imported"
  end
end
