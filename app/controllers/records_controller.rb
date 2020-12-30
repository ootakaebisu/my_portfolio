class RecordsController < ApplicationController
  def new
    @mission = Mission.find_by(user_id: current_user.id, status: "doing")
    @daily_records = @mission.time_attacks.where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day).count + @mission.records.where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day).count
    @record = Record.new
    @records = @mission.records.all
  end

  def create
    @record = Record.new(record_params)
    if @record.save
      redirect_back(fallback_location: root_path)
    else
      @mission = Mission.find_by(user_id: current_user.id, status: "doing")
      @records = @mission.records.all
      render 'new'
    end
  end

  def index
  end

  def destroy
    @record = Record.find(params[:id])
    @record.destroy
    redirect_back(fallback_location: root_path)
  end

  protected
  def record_params
    params.require(:record).permit(:mission_id, :title)
  end

end
