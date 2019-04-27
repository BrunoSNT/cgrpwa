class Extract < ApplicationRecord
  belongs_to :user
  after_create :update_user_beneficial_politics
  after_create :send_notification
  before_destroy :correct_user_beneficial_politics

  enum kind: [:credit, :debit]

  def send_notification
    Notification.create(title: "Seu saldo foi atualizado", message: "#{self.description} (Valor: #{self.value})", user_id: self.user.id, kind: 2)
  end

  def update_user_beneficial_politics
    if self.credit?
      self.user.beneficial_politics += self.value
    else
      self.user.beneficial_politics -= self.value
    end

    self.user.save
  end

  def correct_user_beneficial_politics
    if self.credit?
      self.user.beneficial_politics -= self.value
    else
      self.user.beneficial_politics += self.value
    end

    self.user.save
  end
end
