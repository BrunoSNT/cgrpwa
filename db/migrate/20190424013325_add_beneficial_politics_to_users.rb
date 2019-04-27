class AddBeneficialPoliticsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :beneficial_politics, :decimal, default: 0
  end
end
