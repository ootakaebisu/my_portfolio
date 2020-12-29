class CreateTimeAttacks < ActiveRecord::Migration[5.2]
  def change
    create_table :time_attacks do |t|
      t.integer :mission_id
      t.string :title
      t.datetime :deadline_at
      t.string :diff_at
      t.datetime :finish_at
      t.integer :status, default: 0


      t.timestamps
    end
  end
end
