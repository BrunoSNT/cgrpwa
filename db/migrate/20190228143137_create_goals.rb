class CreateGoals < ActiveRecord::Migration[5.2]
  def change
    create_table :goals do |t|
      t.string :name
      t.text :description
      t.float :value
      t.integer :kind

      t.timestamps
    end
  end
end
