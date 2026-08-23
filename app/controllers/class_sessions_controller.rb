class ClassSessionsController < ApplicationController
  def new
    @taught_courses = current_user.taught_courses
    @class_session = ClassSession.new

    if params[:course_id]
      @class_session.course_id = params[:course_id]
    end

    now = Time.current
    @class_session.starts_at = (now + 1.hour).change(min: 0)
    @class_session.ends_at = @class_session.starts_at + 2.hours
  end

  def create
    current_course = current_user.taught_courses.find(params[:course_id])

    ClassSession.create(
      topic: params[:topic],
      description: params[:description],
      starts_at: params[:starts_at],
      ends_at: params[:ends_at],
      location_type: params[:location_type],
      city: params[:city],
      street: params[:street],
      building_number: params[:building_number],
      room: params[:room],
      platform: params[:platform],
      meeting_url: params[:meeting_url],
      course: current_course
    )

    redirect_to courses_manage_path(params[:course_id])
  end
end
