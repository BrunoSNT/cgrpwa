class DidGood < ApplicationRecord

  belongs_to :sender, class_name: :User, counter_cache: :did_goods_sent
  belongs_to :receiver, class_name: :User, counter_cache: :did_goods_received

  validates_presence_of :description

  after_create :att_saw_did_good
  after_create :check_if_superdidgood

  has_one_attached :photo

  def att_saw_did_good
    self.receiver.sawdidgood = false
    self.receiver.save
  end

  def check_if_superdidgood
    if self.is_superdidgood
      self.sender.coins -= Setup.last.superdidgood_price
      self.sender.save

      Notification.create(title: "Mandou-superbem enviado!", message: "Você mandou um Mandou-superbem e foram debitadas 100 focoins da sua conta", user_id: self.sender.id, kind: 1)
    end
  end

end
