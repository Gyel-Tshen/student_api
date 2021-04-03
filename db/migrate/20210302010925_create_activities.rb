class CreateActivities < ActiveRecord::Migration[6.1]
  def change
    create_table :activities do |t|
      t.string :aname
      t.string :types
      t.string :category
      t.date :date
      
      
      t.timestamps
    end
  end
end
