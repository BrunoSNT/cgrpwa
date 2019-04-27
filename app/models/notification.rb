class Notification < ApplicationRecord
  belongs_to :user
  after_create :att_saw_notifications

  enum kind: [ :bell, :ticket, :cash]

  def att_saw_notifications
    self.user.sawnotifications = false
    self.user.save
  end
end
