class CoursesController < ApplicationController
  def index
    @courses = Course.all
  end

  def my_courses
    if current_user.role == "teacher"
      @courses = Course.where(teacher_id: current_user.id)
    elsif current_user.role == "student"
      @courses = current_user.courses
    end
  end

  def show
  end

  def new
  end

  def create_enrollment
    course = Course.find(params[:id])

    if course.invite_code == params[:invite_code]
      Enrollment.create(user_id: current_user.id, course_id: course.id)

      redirect_to my_courses_path
    else
      @error = "Invalid invite code"
      render :enroll
    end
  end

  def enroll
  end

  def create
    new_code = params[:invite_only] == 1 ? SecureRandom.hex(5).upcase : nil
    Course.create(
      name: params[:name],
      description: params[:description],
      teacher_id: current_user.id,
      invite_code: new_code
    )
    redirect_to my_courses_path
  end
end
