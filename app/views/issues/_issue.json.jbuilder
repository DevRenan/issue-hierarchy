json.extract! issue, :id, :workspace_id, :node_id, :title, :description, :status, :priority, :created_at, :updated_at
json.url issue_url(issue, format: :json)
