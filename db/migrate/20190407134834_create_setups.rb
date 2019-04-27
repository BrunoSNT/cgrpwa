class CreateSetups < ActiveRecord::Migration[5.2]
  def change
    create_table :setups do |t|
      t.integer :weekly_hours
      t.integer :superdidgood_price

      t.timestamps
    end
  end
end
