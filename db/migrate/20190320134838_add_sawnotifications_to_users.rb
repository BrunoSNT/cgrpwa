class AddSawnotificationsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :sawnotifications, :boolean, default: false
  end
end
