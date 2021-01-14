class MissionsController < ApplicationController
  def new
    @mission = Mission.new
  end

  def create
    @mission = Mission.new(mission_params)
    @mission.user_id = current_user.id
    if @mission.save
      redirect_to result_missions_path(id: @mission.id)
    else
      render :new
    end
  end

  def result
    @mission = Mission.find(params[:id])
  end

  def show
    @time_attack = TimeAttack.new
    @mission = Mission.find_by(user_id: current_user.id, status: "doing")
    if @mission.present?
      # 降順.order(id: "DESC")
      @time_attacks = TimeAttack.where(mission_id: @mission.id, created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day).order(id: "DESC")
      @small_goals = @mission.small_goals.order(:row_order)
    end
    @daily_clear = DailyClear.new
    if @mission.present?
      @daily_clear_status = @mission.daily_clears.find_by(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)
      @daily_records = @mission.time_attacks.where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day).count + @mission.records.where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day).count
    end
    @small_goal = SmallGoal.new
  end

  def edit
    @mission = Mission.find_by(user_id: current_user.id, status: "doing")
    @daily_clear = DailyClear.new
    if @mission.present?
      @daily_clear_status = @mission.daily_clears.find_by(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)
    end 
  end

  def update
    @mission = Mission.find(params[:id])
    n = params[:order_sort].to_i
    case n
    when 1
      @mission.update(mission_params)
      redirect_to complete_mission_path(id: @mission)
    else
      if @mission.update(mission_params)
        flash[:notice] = "ミッションの更新に成功しました！"
        redirect_to edit_mission_path
      else
        render :edit
      end
    end
  end  

  def complete
    @mission = Mission.where(user_id: current_user.id, status: "after").last
    # 総記録数の計算(nilの場合の処理)
    if @mission.records.present? && @mission.time_attacks.present?
      @records = @mission.records.count + @mission.time_attacks.count
    elsif @mission.records.present? && @mission.time_attacks.nil?
      @records = @mission..records.count
    elsif @mission.records.nil? && @mission.time_attacks.present?
      @records = @mission.time_attacks.count
    else
      @records = 0
    end
    # スモールゴール達成数

    # 締め切りを何日早められたか?
    if @mission.deadline_on.present?
      require "date"
      d1 = @mission.updated_at
      d2 = @mission.deadline_on
      @diff = Date.parse(d1.to_s) - d2
    end
  end

  def destroy
    @mission = Mission.find(params[:id])
    @mission.destroy
    redirect_to new_record_path
  end



  protected
  def mission_params
    params.require(:mission).permit(:user_id, :title, :record_title, :deadline_on, :status)
  end
end
