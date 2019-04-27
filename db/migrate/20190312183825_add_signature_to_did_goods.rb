class AddSignatureToDidGoods < ActiveRecord::Migration[5.2]
  def change
    add_column :did_goods, :signature, :string, default: "Mandou Bem!"
  end
end
