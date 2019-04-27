class DealMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.deal_mailer.confirmation.subject
  #
  def confirmation
    @deal = params[:deal]
    mail to: @deal.user.email, subject: "Deal Confirmation"
  end
end
