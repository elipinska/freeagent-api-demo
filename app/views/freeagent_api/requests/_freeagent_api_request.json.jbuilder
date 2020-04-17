json.extract! freeagent_api_request, :id, :endpoint, :method, :created_at, :updated_at
json.url freeagent_api_request_url(freeagent_api_request, format: :json)
