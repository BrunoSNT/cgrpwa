class Payment < ApplicationRecord
  enum status: [:a_receber, :pendente, :atrasado, :pago, :recibo_feito]

  validates :value, presence: true
  validates :payment_date, presence: true

  after_update :update_house_of_coin
  after_update :send_client_email

  belongs_to :project
  has_one_attached :hour_report

  def update_house_of_coin
    if self.pago?
      @setup = Setup.last
      @roles_quantity = self.project.roles_quantity
      @devs_percentage = ((@setup.devs_percentage).to_f/100.0)/(@roles_quantity["Gerente"]+@roles_quantity["Desenvolvedor"]).to_f
      @negs_percentage = ((@setup.negs_percentage).to_f/100.0)/(@roles_quantity["Negociador"].to_f)
      puts "PORCENTAGENS"
      p @devs_percentage
      p @negs_percentage
      self.project.users.uniq.each do |user|
        user.project_roles(self.project).each do |role|
          if(role.name == "Gerente" or role.name == "Desenvolvedor")
            Extract.create(user: user, value: (self.value)*@devs_percentage, description: "Política de Benefícios - Projeto #{self.project.name}", kind: 0)
          else
            Extract.create(user: user, value: (self.value)*@negs_percentage, description: "Política de Benefícios (Neg) - Projeto #{self.project.name}", kind: 0)
          end
        end
      end
    end
  end

  def send_client_email
    if self.pendente?
      PaymentsMailer.with(client: self.project.client, project: self.project, payment: self).pending_payment.deliver_later!
    end
  end
end
