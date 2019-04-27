class Core < ApplicationRecord
  has_many :user_core_occupations
  has_many :users, through: :user_core_occupations
  has_many :occupations, through: :user_core_occupations
end
