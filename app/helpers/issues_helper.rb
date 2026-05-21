module IssuesHelper
  def status_badge(status)
	case status.to_s
	when "open"
	  tag.span("Open", class: "text-xs px-2 py-0.5 rounded-full bg-green-100 text-green-800")
	when "in_progress"
	  tag.span("In progress", class: "text-xs px-2 py-0.5 rounded-full bg-yellow-100 text-yellow-800")
	when "resolved"
	  tag.span("Resolved", class: "text-xs px-2 py-0.5 rounded-full bg-blue-100 text-blue-800")
	when "closed"
	  tag.span("Closed", class: "text-xs px-2 py-0.5 rounded-full bg-gray-100 text-gray-700")
	else
	  tag.span(status.to_s.humanize, class: "text-xs px-2 py-0.5 rounded-full bg-gray-100 text-gray-700")
	end
  end

  def priority_badge(priority)
	case priority.to_s
	when "low"
	  tag.span("Low", class: "text-xs px-2 py-0.5 rounded-full bg-green-50 text-green-700")
	when "medium"
	  tag.span("Medium", class: "text-xs px-2 py-0.5 rounded-full bg-yellow-50 text-yellow-700")
	when "high"
	  tag.span("High", class: "text-xs px-2 py-0.5 rounded-full bg-orange-50 text-orange-700")
	when "critical"
	  tag.span("Critical", class: "text-xs px-2 py-0.5 rounded-full bg-red-50 text-red-700")
	else
	  tag.span(priority.to_s.humanize, class: "text-xs px-2 py-0.5 rounded-full bg-gray-50 text-gray-700")
	end
  end
end
