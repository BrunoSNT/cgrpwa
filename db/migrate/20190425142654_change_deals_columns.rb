class ChangeDealsColumns < ActiveRecord::Migration[5.2]
  def change
    change_column :deals, :telephone1, :string
    change_column :deals, :telephone2, :string
    change_column :deals, :price, :decimal
  end
end
