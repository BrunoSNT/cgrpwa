class CreateExtracts < ActiveRecord::Migration[5.2]
  def change
    create_table :extracts do |t|
      t.references :user, foreign_key: true
      t.integer :kind
      t.text :description
      t.decimal :value

      t.timestamps
    end
  end
end
