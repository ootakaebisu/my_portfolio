class CreateCalendarData < ActiveRecord::Migration[5.2]
  def change
    create_table :calendar_data do |t|
      t.integer :user_id
      t.string :title
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps
    end
  end
end
