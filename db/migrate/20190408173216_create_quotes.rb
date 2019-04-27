class CreateQuotes < ActiveRecord::Migration[5.2]
  def change
    create_table :quotes do |t|
      t.string :name
      t.text :description
      t.integer :value

      t.timestamps
    end
  end
end
