class Document < ApplicationRecord
  has_one_attached :file
  validates :name, presence: true # Make sure the owner's name is present.
end
