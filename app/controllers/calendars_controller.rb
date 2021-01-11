class CalendarsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @calendar = Calendar.new
    @calendars = Calendar.all
    # ここから/部分テンプレート呼び出し
    if current_user.missions.present? && current_user.missions.find_by(status: "doing").present?
      @mission = Mission.find_by(user_id: current_user.id, status: "doing")
      @daily_clear = DailyClear.new
      @daily_clear_status = @mission.daily_clears.find_by(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)
    end
    # ここまで/部分テンプレート呼び出し
  end

  def create
    @calendar = Calendar.new(calendar_params)
    if @calendar.save
      redirect_to calendars_path
    else
      render :index
    end
  end

  def update
  end

  protected
  def calendar_params
    params.require(:calendar).permit(:user_id, :title, :description, :start_date, :end_date)
  end
end
