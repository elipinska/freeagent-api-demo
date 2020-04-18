# frozen_string_literal: true
require "net/http"

module FreeagentApi
  class Client
    attr_accessor :client_id, :secret, :redirect_uri, :base_uri, :token_uri

    CLIENT_ID = Rails.configuration.oauth[:client_id]
    CLIENT_SECRET = Rails.configuration.oauth[:secret]
    REDIRECT_URI = Rails.configuration.oauth[:redirect_uri]
    BASE_URI = Rails.configuration.oauth[:base_uri]
    TOKEN_URI = Rails.configuration.oauth[:token_uri]

    def authorize_url
      URI("#{BASE_URI}redirect_uri=#{REDIRECT_URI}&response_type=code&client_id=#{CLIENT_ID}")
    end

    def request_access_token(authorisation_code:)
      uri = TOKEN_URI
      body = {
        grant_type: "authorization_code",
        code: authorisation_code,
        redirect_uri: REDIRECT_URI,
      }

      HTTParty.post(uri, basic_auth: basic_auth, body: body)
    end

    def refresh_access_token(refresh_token:)
      uri = TOKEN_URI
      body = {
        grant_type: "refresh_token",
        refresh_token: refresh_token,
      }

      response = HTTParty.post(uri, basic_auth: basic_auth, body: body)
    end

    def send_request(authentication:, request:)
      request_body = parsed_body(message: request)
      response_json = HTTParty.public_send(
        request.method,
        "https://api.sandbox.freeagent.com/#{request.endpoint}",
        headers: {
        "Authorization": "Bearer #{authentication.access_token}"
        },
        body: request_body)
    end

    def parsed_body(message:)
      body = message.body
      JSON.parse(body) if body.present?
    end

    private

    def basic_auth
      {
        username: CLIENT_ID,
        password: CLIENT_SECRET,
      }
    end
  end
end
