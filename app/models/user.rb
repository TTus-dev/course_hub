class User < ApplicationRecord
  has_many :taught_courses,
           class_name: "Course",
           foreign_key: :teacher_id
end
