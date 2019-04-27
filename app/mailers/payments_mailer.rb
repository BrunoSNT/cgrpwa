class PaymentsMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.payments_mailer.pending_payment.subject
  #
  def pending_payment
    @client = params[:client]
    @project = params[:project]
    @payment = params[:payment]

    if @payment.hour_report.attached?
      attachments[@payment.hour_report.filename.to_s] = (@payment.hour_report.blob.download)
    end
    mail(to: @client.client_email, subject: "[CJR] - Pagamento pendente.")
  end
end
