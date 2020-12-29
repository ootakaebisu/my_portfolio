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
  end

  def edit
  end

  def update
  end

  def daily_clear
  end

  def complete
  end
end
