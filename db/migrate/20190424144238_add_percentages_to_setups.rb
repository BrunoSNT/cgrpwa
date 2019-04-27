class AddPercentagesToSetups < ActiveRecord::Migration[5.2]
  def change
    add_column :setups, :devs_percentage, :integer, default: 15
    add_column :setups, :negs_percentage, :integer, default: 8
  end
end
