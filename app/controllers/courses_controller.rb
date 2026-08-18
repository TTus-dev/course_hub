class CoursesController < ApplicationController
  def index
    @courses = Course.all
  end

  def my_courses
    if current_user.role == "teacher"
      @courses = Course.where(teacher_id: current_user.id, archived: false)
    elsif current_user.role == "student"
      @courses = current_user.courses.where(archived: false)
    end
  end

  def my_archived_courses
    if current_user.role == "teacher"
      @courses = Course.where(teacher_id: current_user.id, archived: true)
    elsif current_user.role == "student"
      @courses = current_user.courses.where(archived: true)
    end
  end

  def show
    course = Course.find(params[:id])

    @course_details = {
      name: course.name,
      description: course.description,
      teacher: course.teacher,
    }
  end

  def new
  end

  def create
    new_code = params[:invite_only] == "1" ? SecureRandom.hex(5).upcase : nil
    Course.create(
      name: params[:name],
      description: params[:description],
      teacher_id: current_user.id,
      invite_code: new_code,
      archived: false
    )
    redirect_to my_courses_path
  end

  def archive
    Course.find(params[:id]).update(archived: true)
    redirect_to my_courses_path
  end

  def reactivate
    course = Course.find(params[:id])

    course.update(
      name: course.name,
      description: course.description,
      archived: false,
      )

    redirect_to my_archived_courses_path
  end

  def manage
    @course = current_user.taught_courses.find(params[:id])
  end

  def update
    course = current_user.taught_courses.find(params[:id])

    if course.invite_code.present? && params[:invite_only] == "0"
      inv_code = nil
    elsif !course.invite_code.present? && params[:invite_only] == "1"
      inv_code = SecureRandom.hex(5).upcase
    else
      inv_code = course.invite_code
    end

    course.update(
      name: params[:name] || course.name,
      description: params[:description] || course.description,
      archived: course.archived,
      invite_code: inv_code
    )

    redirect_to my_courses_path
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
end
