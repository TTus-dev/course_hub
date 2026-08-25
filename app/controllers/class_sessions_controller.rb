class ClassSessionsController < ApplicationController
  def new
    @taught_courses = current_user.taught_courses.where(archived: false)
    @class_session = ClassSession.new

    if params[:course_id]
      @class_session.course_id = params[:course_id]
    end

    now = Time.current
    @class_session.starts_at = (now + 1.hour).change(min: 0)
    @class_session.ends_at = @class_session.starts_at + 2.hours
  end

  def create
    current_course = current_user.taught_courses.find(params[:class_session][:course_id])

    @class_session = current_course.class_sessions.new(class_session_params)

    if @class_session.save
      redirect_to courses_manage_path(current_course.id)
    else
      @taught_courses = current_user.taught_courses
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @class_session = ClassSession.find(params[:id])
  end

  def edit
    @class_session = ClassSession.find(params[:id])
    @taught_courses = current_user.taught_courses
  end

  def update
    @class_session = ClassSession.find(params[:id])

    if @class_session.update(class_session_params)
      redirect_to class_session_path(@class_session)
    else
      @taught_courses = current_user.taught_courses
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    class_session = ClassSession.find(params[:id])
    course = class_session.course

    class_session.destroy

    redirect_to courses_manage_path(course.id)
  end

  private

  def class_session_params
    params.require(:class_session).permit(
      :topic,
      :description,
      :starts_at,
      :ends_at,
      :location_type,
      :city,
      :street,
      :building_number,
      :room,
      :platform,
      :meeting_url,
      :course_id
    )
  end
end
