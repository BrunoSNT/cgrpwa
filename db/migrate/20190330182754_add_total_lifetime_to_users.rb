class AddTotalLifetimeToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :total_lifetime, :string
  end
end
