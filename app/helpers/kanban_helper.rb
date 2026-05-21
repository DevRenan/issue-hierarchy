module KanbanHelper
  def status_badge(status)
    color = {
      "open" => "bg-green-100 text-green-800",
      "in_progress" => "bg-yellow-100 text-yellow-800",
      "resolved" => "bg-blue-100 text-blue-800",
      "closed" => "bg-gray-100 text-gray-700"
    }[status.to_s] || "bg-gray-100 text-gray-700"
    content_tag :span, status.titleize, class: "inline-block px-2 py-0.5 rounded-full text-xs font-semibold #{color}"
  end

  def priority_badge(priority)
    color = {
      "critical" => "bg-red-50 text-red-700 border border-red-200",
      "high" => "bg-orange-50 text-orange-700 border border-orange-200",
      "medium" => "bg-yellow-50 text-yellow-700 border border-yellow-200",
      "low" => "bg-green-50 text-green-700 border border-green-200"
    }[priority.to_s] || "bg-gray-50 text-gray-700 border"
    content_tag :span, priority.titleize, class: "inline-block px-2 py-0.5 rounded-full text-xs font-semibold #{color}"
  end

  def kanban_column_color(status)
    {
      "open" => "bg-green-50 border-green-200",
      "in_progress" => "bg-yellow-50 border-yellow-200",
      "resolved" => "bg-blue-50 border-blue-200",
      "closed" => "bg-gray-50 border-gray-200"
    }[status.to_s] || "bg-gray-50 border-gray-200"
  end
end

