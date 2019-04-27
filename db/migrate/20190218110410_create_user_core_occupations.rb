class CreateUserCoreOccupations < ActiveRecord::Migration[5.2]
  def change
    create_table :user_core_occupations do |t|
      t.references :user, foreign_key: true
      t.references :core, foreign_key: true
      t.references :occupation, foreign_key: true
      t.date :enterdate

      t.timestamps
    end
  end
end
