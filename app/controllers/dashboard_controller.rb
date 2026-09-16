class DashboardController < ApplicationController
  def index
    if current_user.role == "student"
      @upcoming_classes = ClassSession
                            .where(course: current_user.courses)
                            .where("class_sessions.ends_at > ?", Time.current)
                            .order("class_sessions.starts_at ASC")
                            .limit(5)

      @upcoming_assignments = Assignment
                                .where(course: current_user.courses)
                                .where("assignments.due_at > ?", Time.current)
                                .where.not(id: current_user.submissions.select(:assignment_id))
                                .includes(:course)
                                .order(:due_at)
                                .limit(5)

    else
      @upcoming_classes = ClassSession
                            .where(course: current_user.taught_courses)
                            .where("class_sessions.ends_at > ?", Time.current)
                            .order("class_sessions.starts_at ASC")
                            .limit(5)

      @assignments_to_grade = Assignment
                                .where(course: current_user.taught_courses)
                                .where("assignments.due_at < ?", Time.current)
                                .joins(:submissions)
                                .includes(:course)
                                .select(
                                  "assignments.*",
                                  "COUNT(submissions.id) AS total_count",
                                  "COUNT(submissions.id) FILTER (WHERE submissions.grade IS NOT NULL) AS graded_count"
                                )
                                .group("assignments.id")
                                .having("COUNT(submissions.id) FILTER (WHERE submissions.grade IS NULL) > 0")
                                .order(:due_at)
                                .limit(5)
    end
  end
end
