json.extract! node, :id, :workspace_id, :name, :description, :node_type, :ancestry, :created_at, :updated_at
json.url node_url(node, format: :json)
