class AddInviteCodeToCourses < ActiveRecord::Migration[8.1]
  def change
    add_column :courses, :invite_code, :string
  end
end
