class AssignmentsController < ApplicationController
  def index
    if current_user.role == "teacher"
      @assignments = Assignment
                       .where(course: current_user.taught_courses)
                       .includes(:course)
                       .order(:due_at)
    elsif current_user.role == "student"
      @assignments = Assignment
                       .where(course: current_user.courses)
                       .includes(:course)
                       .order(:due_at)
    end
  end

  def show
    @assignment = Assignment.find(params[:id])
  end

  def new
    @taught_courses = current_user.taught_courses.where(archived: false)

    @assignment = Assignment.new

    @assignment.due_at = (Time.current + 7.days)

    if params[:course_id]
      @assignment.course_id = params[:course_id]
    end
  end

  def create
    current_course = current_user.taught_courses.find(params[:assignment][:course_id])

    @assignment = current_course.assignments.new(assignment_params)

    if @assignment.save
      redirect_to courses_manage_path(current_course.id)
    else
      @taught_courses = current_user.taught_courses.where(archived: false)
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @taught_courses = current_user.taught_courses.where(archived: false)
    @assignment = Assignment.find(params[:id])
    @assignment.due_at = @assignment.due_at
  end

  def update
    @assignment = Assignment.find(params[:id])

    if @assignment.update(assignment_params)
      redirect_to assignment_path(id: @assignment.id)
    else
      @taught_courses = current_user.taught_courses
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    assignment = Assignment.find(params[:id])
    course = assignment.course

    assignment.destroy

    redirect_to courses_manage_path(course.id)
  end

  private

  def assignment_params
    params.require(:assignment).permit(
      :topic,
      :description,
      :due_at,
      :course_id
    )
  end
end
