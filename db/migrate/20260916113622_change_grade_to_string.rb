class ChangeGradeToString < ActiveRecord::Migration[8.1]
  def change
    change_column :submissions, :grade, :string
  end
end
