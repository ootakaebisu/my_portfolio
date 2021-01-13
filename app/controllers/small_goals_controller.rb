class SmallGoalsController < ApplicationController
  def create
    @small_goal = SmallGoal.new(small_goal_params)
    if @small_goal.save
      redirect_back(fallback_location: root_path)
    else
      render template: "missions/show"
    end
  end

  def sort
    small_goal = SmallGoal.find(params[:small_goal_id])
    small_goal.update(small_goal_params)
    render body: nil
  end

  def update
    @small_goal = SmallGoal.find(params[:id])
    @small_goal.update(small_goal_params)
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @small_goal = SmallGoal.find(params[:id])
    @small_goal.destroy
    redirect_back(fallback_location: root_path)
  end

  protected
  def small_goal_params
    params.require(:small_goal).permit(:mission_id, :title, :deadline_on, :status, :row_order_position)
  end
end
