class CreateGantts < ActiveRecord::Migration[5.2]
  def change
    create_table :gantts do |t|
      t.references :user
      t.string :name
      t.string :desc
      t.datetime :from
      t.datetime :to
      t.string :label
      t.string :customClass

      t.timestamps
    end
  end
end
