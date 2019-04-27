class Item < ApplicationRecord
  has_one_attached :image
  validates :name, presence: true
  validates :description, presence: true
  validates :value, presence: true
  validates :quantity, presence: true

end
