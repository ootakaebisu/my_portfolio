class RecordsController < ApplicationController
  before_action :authenticate_user!

  def new
    if current_user.missions.present? && current_user.missions.find_by(status: "doing").present?
      @mission = Mission.find_by(user_id: current_user.id, status: "doing")
      # 部分テンプレート用(side)
      @daily_clear = DailyClear.new
      @daily_clear_status = @mission.daily_clears.find_by(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)
    end
    if @mission.present?
      @daily_records = @mission.time_attacks.where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day).count + @mission.records.where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day).count
    end
    if @mission.present? && @mission.records.present?
      @records = Record.where(mission_id: @mission.id, created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day).order(id: "DESC")
    end
    @record = Record.new
    @small_goal = SmallGoal.new
    if @mission.present?
      @small_goals = @mission.small_goals.rank(:row_order)
    end
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
    # 以下終了済みミッションのレコード表示の記述箇所
    if Mission.where(user_id: current_user.id, status: "after").present?
      @finish_missions = Mission.where(user_id: current_user.id, status: "after")
      i = @finish_missions.count #範囲オブジェクトの上限値として使うために終了済みミッションの個数をiと定義
      @n = params[:order_sort].to_i
    end
    case @n
    when 1..i #order_sortが1~iの時
      @mission = Mission.where(user_id: current_user.id, status: "after").limit(@n).last
      # @record_paginate = @record_count.page(params[:page]).per(8) #whereで取り出したデータにページネーションを適用

    #以下最新ミッションのレコード表示の記述箇所(order_sortがnil)
    else
      @mission = Mission.find_by(user_id: current_user.id, status: "doing")
      @daily_clear = DailyClear.new
      if @mission.present? && @mission.daily_clears.present? && @mission.daily_clears.find_by(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day).present?
        @daily_clear_status = @mission.daily_clears.find_by(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)
      end
      # @record_paginate = Item.page(params[:page]).per(8)
    end

    if @mission.present? && @mission.records.present?
      @records = @mission.records
    end

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
