class DashboardController < ApplicationController
  def index
    if current_user.role == "student"
      @upcoming_classes = ClassSession
                            .where(course: current_user.courses)
                            .where("class_sessions.ends_at > ?", Time.current)
                            .order("class_sessions.starts_at ASC")
                            .limit(5)
    else
      @upcoming_classes = ClassSession
                            .where(course: current_user.taught_courses)
                            .where("class_sessions.ends_at > ?", Time.current)
                            .order("class_sessions.starts_at ASC")
                            .limit(5)
    end
  end
end
