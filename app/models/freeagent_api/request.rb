class FreeagentApi::Request < ApplicationRecord
  def make_request(authentication:)
    response_json = HTTParty.get("https://api.sandbox.freeagent.com/#{endpoint}", headers: {
      "Authorization": "Bearer #{authentication.access_token}"
      }).body
    parsed_response = JSON.parse(response_json)

    object_name = parsed_response.keys.first
    details = parsed_response[object_name]

    {name: object_name, details: details}
  end
end
