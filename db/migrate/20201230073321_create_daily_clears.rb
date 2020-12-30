class CreateDailyClears < ActiveRecord::Migration[5.2]
  def change
    create_table :daily_clears do |t|
      t.integer :mission_id
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
