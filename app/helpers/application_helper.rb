module ApplicationHelper
  def health_status_badge(measure)
    badge_status = if measure.notificable?
      'badge badge-warning'
    else
      'badge badge-success'
    end

    content_tag(:span, measure.health_status, class: badge_status)
  end
end
