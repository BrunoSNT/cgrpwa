class CreateRepays < ActiveRecord::Migration[5.2]
  def change
    create_table :repays do |t|
      t.references :user, foreign_key: true
      t.text :description
      t.float :value
      t.integer :kind, default: 0

      t.timestamps
    end
  end
end
