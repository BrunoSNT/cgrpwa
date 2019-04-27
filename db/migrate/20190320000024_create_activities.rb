class CreateActivities < ActiveRecord::Migration[5.2]
  def change
    create_table :activities do |t|
      t.references :user, foreign_key: true
      t.references :activity_category, foreign_key: true
      t.string :name
      t.text :description
      t.integer :status

      t.timestamps
    end
  end
end
