module DashboardHelper
  def class_session_date(class_session)
    start_date = class_session.starts_at
    end_date = class_session.ends_at

    if start_date.to_date == end_date.to_date
      start_date.strftime("%d %b")
    else
      "#{start_date.strftime("%d %b")} - #{end_date.strftime("%d %b")}"
    end
  end

  def class_session_time(class_session)
    start_time = class_session.starts_at
    end_time = class_session.ends_at

    if start_time <= Time.current
      "Now - #{end_time.strftime("%H:%M")}"
    else
      "#{start_time.strftime("%H:%M")} - #{end_time.strftime("%H:%M")}"
    end
  end
end
