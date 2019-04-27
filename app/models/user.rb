class User < ApplicationRecord
  include Rails.application.routes.url_helpers
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable

  has_many :user_core_occupations, dependent: :destroy
  has_many :cores, through: :user_core_occupations
  has_many :occupations, through: :user_core_occupations
  has_many :user_projects
  has_many :projects, through: :user_projects
  has_many :activities
  has_many :user_activities
  has_many :notifications
  has_many :orders
  has_many :extracts
  has_many :repays
  has_many :deals

  has_many(:did_goods, foreign_key: :receiver_id, dependent: :destroy)
  has_many(:reverse_did_goods, class_name: :DidGood, foreign_key: :sender_id, dependent: :destroy)
  has_many :users, through: :did_goods, source: :sender


  has_one_attached :avatar
  after_create :update_access_token!

  def full_name
    unless self.username.blank?
      self.username
    else
      name = "#{self.first_name} #{self.last_name}".titleize.split
      "#{name.first} #{name.last}"
    end
  end

  def avatar_url
    # self.avatar.service_url if self.avatar.attached? #define default host
    rails_blob_path(self.avatar) if self.avatar.attached?
  end

  def main_occupation
    self.occupations.first.name
  end

  def did_goods_received_month
    self.did_goods.where(created_at: Time.now.beginning_of_month..Time.now.end_of_month).count
  end

  def did_goods_sent_month
    self.reverse_did_goods.where(created_at: Time.now.beginning_of_month..Time.now.end_of_month).count
  end

  def update_access_token!
    self.access_token = "#{self.id}:#{Devise.friendly_token}"
    save
  end

  def has_director_access?
    is_director = self.occupations.any? do |occupation|
      occupation.is_admin
    end

    is_director
  end

  def user_activities_subscriptions
    atividades = []
    UserActivity.where(user: self).each do |user_activity|
      atividade = Activity.find(user_activity.activity_id)
      if atividade.activity_date > DateTime.now
        atividades << atividade
      end
    end

    atividades.sort_by {|obj| obj.activity_date}
  end

  def project_roles(project)
    UserProject.where(project: project).where(user: self).map{ |up| up.role}
  end
end
