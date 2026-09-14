class User < ApplicationRecord
  has_many :taught_courses,
           class_name: "Course",
           foreign_key: :teacher_id

  has_many :enrollments
  has_many :courses, through: :enrollments

  has_many :submissions, foreign_key: :user_id, dependent: :destroy

  validates :name, presence: true
  validates :email, presence: true, uniqueness: { message: "already has an account." }
  has_secure_password
  validates :password, confirmation: true
end
