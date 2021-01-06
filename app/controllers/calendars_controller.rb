class CalendarsController < ApplicationController
  def index
    # ここから/部分テンプレート呼び出し
    if current_user.missions.present? && current_user.missions.find_by(status: "doing").present?
      @mission = Mission.find_by(user_id: current_user.id, status: "doing")
      @daily_clear = DailyClear.new
      @daily_clear_status = @mission.daily_clears.find_by(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)
    end
    # ここまで/部分テンプレート呼び出し

    @calendar_data = "豚骨"
    gon.calendar_data = @calendar_data
  end

  def create
  end

  def update
  end
end
