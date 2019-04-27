class AddClockifyKeyToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :clockify_key, :string
  end
end
