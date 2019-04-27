class Order < ApplicationRecord
  belongs_to :user
  belongs_to :item

  after_create :att_user_coins
  after_create :att_item_quantity
  enum status: [ :pendente, :entregue ]

  def att_user_coins
    self.user.coins -= self.item.value
    self.user.save
  end

  def att_item_quantity
    self.item.quantity -= 1
    if self.item.quantity < 1
      self.item.available = false
    end
    self.item.save
  end
end