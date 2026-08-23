class CoursesController < ApplicationController
  def index
    visibilities = Array(params[:visibility])

    @courses =
      if visibilities.empty? || visibilities.size == 2
        Course.all
      elsif visibilities == [ "public" ]
        Course.where(invite_code: nil)
      else
        Course.where.not(invite_code: nil)
      end
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
    @course = Course.find(params[:id])

    @upcoming_classes = @course.class_sessions
                               .where("starts_at >= ?", Time.current)
                               .order(:starts_at)

    if current_user.role == "student"
      @enrollment = @course.enrollments.find_by(user_id: current_user.id)
    end
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

    @upcoming_sessions = @course.class_sessions
                                .where("starts_at > ?", Time.current)
                                .order(:starts_at)
  end

  def update
    course = current_user.taught_courses.find(params[:id])

    if params[:invite_only] == "1"
      inv_code = course.invite_code.presence || SecureRandom.hex(5).upcase
    else
      inv_code = nil
    end

    course.update(
      name: params[:name] || course.name,
      description: params[:description] || course.description,
      archived: course.archived,
      invite_code: inv_code
    )

    redirect_to courses_show_path(course.id)
  end

  def create_enrollment
    @course = Course.find(params[:id])

    if @course.invite_code.present?
      if @course.invite_code != params[:invite_code]
        @error = "Invalid invite code"
        return render :enroll, status: :unprocessable_entity
      end
    end

    Enrollment.create!(
      user_id: current_user.id,
      course_id: @course.id
    )

    redirect_to my_courses_path
  end

  def enroll
    @course = Course.find(params[:id])
  end

  def leave_course
    enrollment = current_user.enrollments.find_by!(course_id: params[:id])
    enrollment.destroy

    redirect_to my_courses_path
  end
end
