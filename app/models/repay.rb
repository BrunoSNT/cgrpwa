class Repay < ApplicationRecord
  belongs_to :user
  before_create :set_status

  validates :value, presence: true
  validates :description, presence: true
  validates :kind, presence: true

  enum status: [:pendente, :negado, :pagamento_aprovado, :pago, :recibo_feito]
  enum kind: [:politica_de_beneficios, :reembolso]

  after_update :update_house_of_coin
  before_update :set_payment_date

  has_one_attached :fiscal_note

  def set_status
    self.status = 0
  end

  def set_payment_date
    if self.pago?
      self.payment_date = Date.today
    end
  end

  def update_house_of_coin
    if self.pago? and self.politica_de_beneficios?
      @extract = Extract.create(user: self.user, value: self.value, description: "#{self.kind.humanize} - #{self.description}", kind: 1)
      RepayMailer.with(user: self.user, extract: @extract).paid.deliver_later!
    end
  end
end
