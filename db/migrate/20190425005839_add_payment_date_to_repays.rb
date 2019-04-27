class AddPaymentDateToRepays < ActiveRecord::Migration[5.2]
  def change
    add_column :repays, :payment_date, :date
  end
end
