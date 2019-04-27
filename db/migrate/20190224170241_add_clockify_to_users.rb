class AddClockifyToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :clockify_user_id, :string
    add_column :users, :clockify_active_workspace_id, :string
    add_column :users, :clockify_refresh_token, :string
  end
end
