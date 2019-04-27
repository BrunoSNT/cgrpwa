class AddNewFieldsToDeals < ActiveRecord::Migration[5.2]
  def change
    add_column :deals, :status, :integer
    add_column :deals, :price, :integer
  end
end
