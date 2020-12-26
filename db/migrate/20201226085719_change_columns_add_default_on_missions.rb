class ChangeColumnsAddDefaultOnMissions < ActiveRecord::Migration[5.2]
  def change
    change_column_default(:missions, :continuation, 0)
    change_column_default(:missions, :recovery, 0)
    change_column_default(:missions, :small_goal_clear, 0)
    change_column_default(:missions, :total_record, 0)
    change_column_default(:missions, :total_time_attack, 0)
    change_column_default(:missions, :status, 0)
  end
end
