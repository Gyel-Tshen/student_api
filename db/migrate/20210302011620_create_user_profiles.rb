class CreateUserProfiles < ActiveRecord::Migration[6.1]
  def change
    create_table :user_profiles do |t|
      t.integer :studentno
      t.string :fname
      t.string :mname
      t.string :lname
      t.string :course
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
