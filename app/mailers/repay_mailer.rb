class RepayMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.repay_mailer.paid.subject
  #
  def paid
    @user = params[:user]
    @extract = params[:extract]

    mail(to: @user.email, subject: '[REEMBOLSO] - Pagamento efetuado.')
  end

end
