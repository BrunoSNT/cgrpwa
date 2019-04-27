class Occupation < ApplicationRecord
  has_many :user_core_occupations
  has_many :users, through: :user_core_occupations
  has_many :cores, through: :user_core_occupations
end
