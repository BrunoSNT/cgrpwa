class AddSawdidgoodsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :sawdidgood, :boolean, default: false
  end
end
