class RepayPreview < ActionMailer::Preview
  # Accessible from http://localhost:3000/rails/mailers/notifier/welcome
  def paid
    RepayMailer.with(user: User.first, extract: Extract.first).paid
  end
end