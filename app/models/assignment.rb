class Assignment < ApplicationRecord
  belongs_to :course
  has_many :submissions, dependent: :destroy

  validates :topic, presence: true

  def overdue?
    due_at.present? && due_at < Time.current
  end
end
