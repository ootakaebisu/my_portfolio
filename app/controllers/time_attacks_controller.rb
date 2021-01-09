class TimeAttacksController < ApplicationController


  def create
    @time_attack = TimeAttack.new(time_attack_params)
    if @time_attack.save
      redirect_back(fallback_location: root_path)
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def update
    @time_attack_created = TimeAttack.find(params[:id])
    @time_attack_created.update(time_attack_params)
    # 実行前=>実行中はstatusのvalueの変更のみで元のページに戻る
    if  @time_attack_created.status == "doing"
      redirect_back(fallback_location: root_path)

    # 実行中=>終了はfinish_atカラムとdiff_atカラムを作ってから元のページに戻る
    elsif @time_attack_created.status == "after"
      require "date"
      @time_attack_created.finish_at = DateTime.now

      # Finishを押した時間から自分が定めた設定時間を引いた秒数を整数で取得
      sec = @time_attack_created.finish_at.to_i - @time_attack_created.deadline_at.to_i
      # secの絶対値を使って差分を出す
      sec_new = sec.abs
      day, sec_r = sec_new.divmod(86400)
      if day == 0
        diff = (Time.parse("1/1") + sec_r).strftime("%H:%M:%S")
      else
        diff = (Time.parse("1/1") + sec_r).strftime("#{day}日%H:%M:%S")
      end
      # secの正と負を文字列に追加
      if sec >= 0
        @time_attack_created.diff = "＋" + diff
      else
        @time_attack_created.diff = "－" + diff
      end

      @time_attack_created.update(time_attack_params)
      redirect_back(fallback_location: root_path)
    end
  end

  def index
    # 以下終了済みミッションのタイムアタック表示の記述箇所
    if Mission.where(user_id: current_user.id, status: "after").present?
      @finish_missions = Mission.where(user_id: current_user.id, status: "after")
      i = @finish_missions.count #範囲オブジェクトの上限値として使うために終了済みミッションの個数をiと定義
      @n = params[:order_sort].to_i
    end
    case @n
    when 1..i #order_sortが1~iの時
      @mission = Mission.find(@n)
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

    if @mission.present? && @mission.time_attacks.present?
      @time_attacks = @mission.time_attacks
    end

  end

  protected
  def time_attack_params
    params.require(:time_attack).permit(:mission_id, :title, :deadline_at, :status, :finish_at, :diff_at)
  end

end

