class Setup < ApplicationRecord
  validate :check_record, on: :create #please not that validate in this case is singular

  def check_record
    if Setup.all.count >= 1
      errors[:base] << "You can only have one active setup"
    end
  end
end
