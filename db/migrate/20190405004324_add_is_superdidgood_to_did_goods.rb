class AddIsSuperdidgoodToDidGoods < ActiveRecord::Migration[5.2]
  def change
    add_column :did_goods, :is_superdidgood, :boolean, default: false
  end
end
