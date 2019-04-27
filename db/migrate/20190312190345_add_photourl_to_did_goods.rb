class AddPhotourlToDidGoods < ActiveRecord::Migration[5.2]
  def change
    add_column :did_goods, :photourl, :string, default: "https://cdn.diariodolitoral.com.br/upload/dn_noticia/2019/01/bolsonaro-fp134.jpg"
  end
end
