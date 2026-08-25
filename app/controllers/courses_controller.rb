class CoursesController < ApplicationController
  def index
    courses = Course.where(archived: false)

    unless params[:include_owned_enrolled] == "1"
      if current_user.role == "teacher"
        courses = courses.where.not(teacher_id: current_user.id)
      elsif current_user.role == "student"
        courses = courses.where.not(id: current_user.enrollments.select(:course_id))
      end
    end

    visibilities = Array(params[:visibility])

    @courses =
      if visibilities.empty? || visibilities.size == 2
        courses.all
      elsif visibilities == [ "public" ]
        courses.where(invite_code: nil)
      else
        courses.where.not(invite_code: nil)
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
                               .where("ends_at > ?", Time.current)
                               .order(:starts_at)

    @past_classes = @course.class_sessions
                           .where("ends_at <= ?", Time.current)
                           .order(ends_at: :desc)

    @students = @course.students

    if current_user.role == "student"
      @enrollment = @course.enrollments.find_by(user_id: current_user.id)
    end
  end

  def new
    @course = Course.new
  end

  def create
    new_code = params[:invite_only] == "1" ? SecureRandom.hex(5).upcase : nil
    @course = Course.new(course_params.merge(
      teacher_id: current_user.id,
      invite_code: new_code,
      archived: false
    ))

    if @course.save
      redirect_to my_courses_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def archive
    course = current_user.taught_courses.find(params[:id])
    course.update!(archived: true)

    redirect_to my_courses_path
  end

  def reactivate
    course = current_user.taught_courses.find(params[:id])
    course.update!(archived: false)

    redirect_to my_archived_courses_path
  end

  def manage
    @course = current_user.taught_courses.where(archived: false).find(params[:id])

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

  private

  def course_params
    params.require(:course).permit(
      :name,
      :description
    )
  end
end
