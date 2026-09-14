class Submission < ApplicationRecord
  belongs_to :assignment
  belongs_to :student, class_name: "User", foreign_key: :user_id

  validates :user_id, uniqueness: { scope: :assignment_id }
end
