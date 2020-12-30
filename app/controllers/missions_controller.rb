class MissionsController < ApplicationController
  def new
  end

  def result
  end

  def show
    @time_attack = TimeAttack.new
    @time_attacks = TimeAttack.all
    @mission = Mission.find_by(user_id: current_user.id, status: "doing")
    if @mission.time_attacks.present?
      @time_attack_created = TimeAttack.find(params[:id])
    end
    @daily_clear = DailyClear.new
    @daily_clear_status = @mission.daily_clears.find_by(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)
    @daily_records = @mission.time_attacks.where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day).count + @mission.records.where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day).count
  end

  def edit
  end

  def update
  end

  def complete
  end
end
