class CreateActivityCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :activity_categories do |t|
      t.string :name
      t.text :description
      t.integer :owner_value
      t.integer :member_value

      t.timestamps
    end
  end
end
