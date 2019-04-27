class AddDidGoodsCountToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :did_goods_sent, :integer, default: 0, null: false
    add_column :users, :did_goods_received, :integer, default: 0, null: false
  end
end
