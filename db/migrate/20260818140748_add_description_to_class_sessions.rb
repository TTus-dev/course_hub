class AddDescriptionToClassSessions < ActiveRecord::Migration[8.1]
  def change
    add_column :class_sessions, :topic, :string
    add_column :class_sessions, :description, :text
  end
end
