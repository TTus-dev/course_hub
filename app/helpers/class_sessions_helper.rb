module ClassSessionsHelper
  def safe_meeting_link(class_session)
    url = class_session.meeting_url.to_s
    uri = URI.parse(url)

    if uri.is_a?(URI::HTTP) || uri.is_a?(URI::HTTPS)
      link_to class_session.platform, url, target: "_blank", rel: "noopener noreferrer", class: "text-blue-400 hover:text-blue-300"
    else
      content_tag(:span, "Invalid link", class: "text-gray-400")
    end
  rescue URI::InvalidURIError
    content_tag(:span, "Invalid link", class: "text-gray-400")
  end
end
