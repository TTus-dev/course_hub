class Assignment < ApplicationRecord
  belongs_to :course

  validates :topic, presence: true
end
