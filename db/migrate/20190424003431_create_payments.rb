class CreatePayments < ActiveRecord::Migration[5.2]
  def change
    create_table :payments do |t|
      t.references :project, foreign_key: true
      t.float :value
      t.date :payment_date

      t.timestamps
    end
  end
end
