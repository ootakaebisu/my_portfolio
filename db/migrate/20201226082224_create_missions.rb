class CreateMissions < ActiveRecord::Migration[5.2]
  def change
    create_table :missions do |t|
      t.integer :user_id
      t.string :title
      t.string :record_title
      t.date :deadline
      t.integer :continuation
      t.integer :recovery
      t.integer :small_goal_clear
      t.integer :total_record
      t.integer :total_time_attack
      t.integer :status

      t.timestamps
    end
  end
end
