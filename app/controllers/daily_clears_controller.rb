class DailyClearsController < ApplicationController
  def show
     @mission = Mission.find_by(user_id: current_user.id, status: "doing")
    @daily_records = @mission.time_attacks.where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day).count + @mission.records.where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day).count
  end

  def create
    @daily_clear = DailyClear.new(daily_clear_params)
    @daily_clear.mission_id = current_user.missions.find_by(user_id: current_user, status: "doing").id
    if @daily_clear.save
      redirect_to daily_clear_path(@daily_clear.id)
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def update
  end

  protected
  def daily_clear_params
    params.require(:daily_clear).permit(:mission_id, :status)
  end

end
