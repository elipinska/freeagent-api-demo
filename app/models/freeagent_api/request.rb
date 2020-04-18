class FreeagentApi::Request < ApplicationRecord
  def make_request(authentication:)
    response_json = HTTParty.get("https://api.sandbox.freeagent.com/#{endpoint}", headers: {
      "Authorization": "Bearer #{authentication.access_token}"
      }).body
    parsed_response = JSON.parse(response_json)
  end
end
