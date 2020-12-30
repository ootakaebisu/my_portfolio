class TimeAttacksController < ApplicationController


  def create
    @time_attack = TimeAttack.new(time_attack_params)
    if @time_attack.save
      redirect_back(fallback_location: root_path)
    else
      render :new
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
  end

  protected
  def time_attack_params
    params.require(:time_attack).permit(:mission_id, :title, :deadline_at, :status, :finish_at, :diff_at)
  end

end

