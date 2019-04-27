class AddIsAdminToOccupations < ActiveRecord::Migration[5.2]
  def change
    add_column :occupations, :is_admin, :boolean, default: false
  end
end
