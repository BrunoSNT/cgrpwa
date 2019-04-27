class UserActivity < ApplicationRecord
  belongs_to :user
  belongs_to :activity
  after_create :notify_user
  after_destroy :notify_user_destroy

  def self.find_user_activity_by_user(user, activity)
    self.where(user: user).find_by(activity_id: activity.id)
  end

  def notify_user
    Notification.create(title: "Inscrito na atividade #{self.activity.name}", message: "Você se inscreveu em #{self.activity.name}, que ocorrerá #{self.activity.activity_date.strftime("%d/%m/%Y %H:%M")}", user_id: self.user.id, kind: 0)
  end

  def notify_user_destroy
    Notification.create(title: "Desenscrito na atividade #{self.activity.name}", message: "Você se desinscreveu em #{self.activity.name}", user_id: self.user.id, kind: 0)
  end
end
