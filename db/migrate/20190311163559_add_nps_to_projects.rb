class AddNpsToProjects < ActiveRecord::Migration[5.2]
  def change
    add_column :projects, :nps, :integer
    add_column :projects, :nps2, :integer
  end
end
