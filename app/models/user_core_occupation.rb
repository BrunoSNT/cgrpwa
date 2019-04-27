class UserCoreOccupation < ApplicationRecord
  belongs_to :user
  belongs_to :core
  belongs_to :occupation
end
