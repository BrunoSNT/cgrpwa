class AddStatusToRepays < ActiveRecord::Migration[5.2]
  def change
    add_column :repays, :status, :integer
  end
end
