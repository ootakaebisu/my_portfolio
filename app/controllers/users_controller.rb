class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:result]

  def show
    # ここから/部分テンプレート呼び出し
    if current_user.missions.present? && current_user.missions.find_by(status: "doing").present?
      @mission = Mission.find_by(user_id: current_user.id, status: "doing")
      @daily_clear = DailyClear.new
      @daily_clear_status = @mission.daily_clears.find_by(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)
    end
    # ここまで/部分テンプレート呼び出し
    @user = current_user
  end

  def index
    if params[:name].present?
      @users = User.where('name LIKE ?', "%#{params[:name]}%")
    else
      @users = User.all
    end
    # ここから/部分テンプレート呼び出し
    if current_user.missions.present? && current_user.missions.find_by(status: "doing").present?
      @mission = Mission.find_by(user_id: current_user.id, status: "doing")
      @daily_clear = DailyClear.new
      @daily_clear_status = @mission.daily_clears.find_by(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)
    end
    # ここまで/部分テンプレート呼び出し
  end

  def follow_users
    # ここから/部分テンプレート呼び出し
    if current_user.missions.present? && current_user.missions.find_by(status: "doing").present?
      @mission = Mission.find_by(user_id: current_user.id, status: "doing")
      @daily_clear = DailyClear.new
      @daily_clear_status = @mission.daily_clears.find_by(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)
    end
    # ここまで/部分テンプレート呼び出し
    @user = User.find(params[:id])
    @users = @user.following_users
  end

  def edit
  # 部分テンプレuser呼び出し部分
    @user = User.find(params[:id])
    if @user.missions.present? && @user.missions.find_by(user_id: @user.id, status: "doing").present?
      # 総記録数の計算(nilの場合の処理)
      @mission = @user.missions.where(user_id: @user.id, status: "doing").last
      if @mission.records.present? && @mission.time_attacks.present?
        @records = @mission.records.count + @mission.time_attacks.count
      elsif @mission.records.present? && @mission.time_attacks.nil?
        @records = @mission..records.count
      elsif @mission.records.nil? && @mission.time_attacks.present?
        @records = @mission.time_attacks.count
      else
        @records = 0
      end
    end
    # ここから/部分テンプレート呼び出し
    if current_user.missions.present? && current_user.missions.find_by(status: "doing").present?

      @daily_clear = DailyClear.new
      @daily_clear_status = @mission.daily_clears.find_by(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)
    end
    # ここまで/部分テンプレート呼び出し
  end

  def update
    @user = User.find(params[:id])
    if @user.update(update_user_params)
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  def unsubscribe
    @user = current_user
  end

  def withdraw
    # boolean型カラムis_deletedのステータスをfaulseからtrueに変更
    current_user.is_deleted = true
    # ユーザーのサインアウト(sign_out関数)
    sign_out
    redirect_to result_users_path
  end

  def result
  end

  def public_page
    # 部分テンプレuser呼び出し部分
      @user = User.find(params[:id])
      if @user.missions.present? && @user.missions.find_by(user_id: @user.id, status: "doing").present?
        # 総記録数の計算(nilの場合の処理)
        @mission = @user.missions.where(user_id: @user.id, status: "doing").last
        if @mission.records.present? && @mission.time_attacks.present?
          @records = @mission.records.count + @mission.time_attacks.count
        elsif @mission.records.present? && @mission.time_attacks.nil?
          @records = @mission..records.count
        elsif @mission.records.nil? && @mission.time_attacks.present?
          @records = @mission.time_attacks.count
        else
          @records = 0
        end
      end

      if @user == current_user
        # ここから/部分テンプレート呼び出し
        if current_user.missions.present? && current_user.missions.find_by(status: "doing").present?
          @daily_clear = DailyClear.new
          @daily_clear_status = @mission.daily_clears.find_by(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)
        end
        # ここまで/部分テンプレート呼び出し
      end
  end

  protected
  def user_params
    params.require(:user).permit(:name, :password, :my_id, :content, :profile_image)
  end

  def update_user_params
    #update時は[_delete]と[id]が必要
    params.require(:user).permit(:name, :password, :my_id, :content, :profile_image, missions_attributes: [:title, :deadline_on, :_destroy, :id])
  end
end
