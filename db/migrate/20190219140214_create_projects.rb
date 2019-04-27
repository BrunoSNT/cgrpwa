class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |t|
      t.string :name
      t.text :description
      t.date :enddate
      t.references :client, foreign_key: true
      t.float :price

      t.timestamps
    end
  end
end
