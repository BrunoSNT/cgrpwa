class Deal < ApplicationRecord
  enum status: [:a_contactar, :demanda_captada, :proposta_marcada, :proposta_apresentada, :contrato_fechado, :encerrado]
  after_create :send_confirmation
  after_update :send_confirmation
  validates :deal_date, presence: true
  validates :client_name, presence: true
  validates :telephone1, presence: true
  validates :email, presence: true
  validates :arrival, presence: true

  belongs_to :user

  def send_confirmation
    DealMailer.with(deal: self).confirmation.deliver_now!
  end
end
