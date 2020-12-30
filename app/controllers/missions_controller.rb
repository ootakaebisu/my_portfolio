class MissionsController < ApplicationController
  def new
    @mission = Mission.new
  end

  def create
    @mission = Mission.new(mission_params)
    if @mission.save
      redirect_to result_missions_path(id: @mission.id)
    else
      render 'new'
    end

  end

  def result
    @mission = Mission.find(params[:id])
  end

  def show
    @time_attack = TimeAttack.new
    @time_attacks = TimeAttack.all
    @mission = Mission.find_by(user_id: current_user.id, status: "doing")
    if @mission.present? && @mission.time_attacks.present?
      @time_attack_created = TimeAttack.find(params[:id])
    end
    @daily_clear = DailyClear.new
    if @mission.present?
      @daily_clear_status = @mission.daily_clears.find_by(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)
      @daily_records = @mission.time_attacks.where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day).count + @mission.records.where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day).count
    end
    @small_goal = SmallGoal.new
  end

  def edit
  end

  def update
  end

  def complete

  end

  protected
  def mission_params
    params.require(:mission).permit(:user_id, :title, :record_title, :deadline_on)
  end
end
