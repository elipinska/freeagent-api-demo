class FreeagentApi::Request < ApplicationRecord
  def make_request(authentication:)
    request_body = JSON.parse(body) if body.present?
    response_json = HTTParty.public_send(
      method,
      "https://api.sandbox.freeagent.com/#{endpoint}",
      headers: {
      "Authorization": "Bearer #{authentication.access_token}"
      },
      body: request_body)
  end

  def parsed_response_body(response:)
    response_body = response.body
    JSON.parse(response_body) if response_body.present?
  end
end
