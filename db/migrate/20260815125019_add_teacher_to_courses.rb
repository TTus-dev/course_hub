class AddTeacherToCourses < ActiveRecord::Migration[8.1]
  def change
    add_reference :courses, :teacher, null: false, foreign_key: { to_table: :users }
  end
end
