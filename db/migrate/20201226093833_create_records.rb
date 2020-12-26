class CreateRecords < ActiveRecord::Migration[5.2]
  def change
    create_table :records do |t|
      t.integer :mission_id
      t.string :title

      t.timestamps
    end
  end
end
