class User < ApplicationRecord
  has_many :taught_courses,
           class_name: "Course",
           foreign_key: :teacher_id

  has_many :enrollments
  has_many :courses, through: :enrollments
  has_secure_password
end
