class Activity < ApplicationRecord
  belongs_to :user
  belongs_to :activity_category
  has_many :user_activities
  has_one_attached :avatar

  validates :activity_date, presence: true
end
