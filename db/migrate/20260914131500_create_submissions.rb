class CreateSubmissions < ActiveRecord::Migration[8.1]
  def change
    create_table :submissions do |t|
      t.references :assignment, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.text :content
      t.datetime :submitted_at
      t.integer :grade
      t.text :feedback

      t.timestamps
    end
  end
end
