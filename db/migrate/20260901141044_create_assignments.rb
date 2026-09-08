class CreateAssignments < ActiveRecord::Migration[8.1]
  def change
    create_table :assignments do |t|
      t.string :topic
      t.text :description
      t.datetime :due_at
      t.references :course, null: false, foreign_key: true

      t.timestamps
    end
  end
end
