json.extract! attachment, :id, :issue_id, :name, :file_path, :created_at, :updated_at
json.url attachment_url(attachment, format: :json)
