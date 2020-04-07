json.extract! task, :id, :description, :completed, :created_at, :updated_at
json.url task_url(task, format: :json)
