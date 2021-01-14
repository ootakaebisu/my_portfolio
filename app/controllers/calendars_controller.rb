class CalendarsController < ApplicationController
  before_action :authenticate_user!

  def index
    @calendar = Calendar.new
    @calendars = Calendar.where(user_id: current_user)
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
      flash[:notice] = "イベントを追加しました！"
      redirect_to calendars_path
    else
      render :index
    end
  end

  def show
    @calendar = Calendar.find(params[:id])
  end

  def update
    @calendar = Calendar.find(params[:id])
    if @calendar.update(calendar_params)
      flash[:notice] = "イベントを更新しました！"
      redirect_to calendar_path(@calendar)
    else
      render :show
    end
  end

  protected
  def calendar_params
    params.require(:calendar).permit(:user_id, :title, :description, :start_date, :end_date)
  end
end
