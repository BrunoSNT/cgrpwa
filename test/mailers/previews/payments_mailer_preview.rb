class PaymentsPreview < ActionMailer::Preview
  # Accessible from http://localhost:3000/rails/mailers/notifier/welcome
  def pending_payment
    PaymentsMailer.with(client: Client.first, project: Project.first, payment: Payment.first).pending_payment
  end
end