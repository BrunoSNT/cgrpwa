class CreateDeals < ActiveRecord::Migration[5.2]
  def change
    create_table :deals do |t|
      t.datetime :deal_date
      t.string :client_name
      t.string :client_company
      t.string :sector
      t.text :sector_description
      t.text :problems
      t.text :address
      t.string :website
      t.integer :telephone1
      t.integer :telephone2
      t.string :email
      t.text :info
      t.string :arrival

      t.timestamps
    end
  end
end
