class SubmissionsController < ApplicationController
  def create
    assignment = Assignment.find(params[:assignment_id])

    submission = assignment.submissions.new(submission_params)
    submission.student = current_user
    submission.submitted_at = Time.current

    if submission.save
      redirect_to assignment_path(assignment)
    else
      redirect_to assignment_path(assignment),
                  alert: "Could not submit assignment."
    end
  end

  def update
    @assignment = Assignment.find(params[:assignment_id])
    @submission = @assignment.submissions.find(params[:id])

    if @submission.update(submission_params)
      redirect_to assignment_path(@assignment)
    else
      render "assignments/show", status: :unprocessable_entity
    end
  end
  private

  def submission_params
    params.require(:submission).permit(:content)
  end
end