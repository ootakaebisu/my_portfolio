class CreateSmallGoals < ActiveRecord::Migration[5.2]
  def change
    create_table :small_goals do |t|
      t.integer :mission_id
      t.string :title
      t.date :deadline_on
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
