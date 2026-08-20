class User < ApplicationRecord
  has_many :taught_courses,
           class_name: "Course",
           foreign_key: :teacher_id

  has_many :enrollments
  has_many :courses, through: :enrollments
  has_secure_password

  validates :name, presence: true
  validates :email, presence: true, uniqueness: { message: "already has an account." }
  validates :password, confirmation: true
end
