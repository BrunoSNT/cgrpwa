class CreateDidGoods < ActiveRecord::Migration[5.2]
  def change
    create_table :did_goods do |t|
      t.integer :sender_id, null: false
      t.integer :receiver_id, null: false
      t.text :description

      t.timestamps
    end
  end
end
