class CreateTimeAttacks < ActiveRecord::Migration[5.2]
  def change
    create_table :time_attacks do |t|
      t.integer :mission_id
      t.string :title
      t.datetime :deadline
      t.integer :status

      t.timestamps
    end
  end
end
