class CreateHours < ActiveRecord::Migration[5.2]
  def change
    create_table :hours do |t|
      t.integer :weekly_hours, default: 12
      t.integer :max_hours, default: 15

      t.timestamps
    end
  end
end
