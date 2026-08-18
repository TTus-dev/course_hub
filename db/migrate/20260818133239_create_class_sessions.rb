class CreateClassSessions < ActiveRecord::Migration[8.1]
  def change
    create_table :class_sessions do |t|
      t.references :course, null: false, foreign_key: true
      t.datetime :starts_at
      t.datetime :ends_at
      t.string :location_type
      t.string :city
      t.string :street
      t.string :building_number
      t.string :room
      t.string :platform
      t.string :meeting_url

      t.timestamps
    end
  end
end
