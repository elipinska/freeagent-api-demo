# frozen_string_literal: true
require "net/http"

module FreeagentApi
  class Client
    attr_accessor :client_id, :secret, :redirect_uri, :base_uri, :token_uri

    def initialize
      @client_id = Rails.configuration.oauth[:client_id]
      @client_secret = Rails.configuration.oauth[:secret]
      @redirect_uri = Rails.configuration.oauth[:redirect_uri]
      @base_uri = Rails.configuration.oauth[:base_uri]
      @token_uri = Rails.configuration.oauth[:token_uri]
    end

    def authorize_url
      URI("#{@base_uri}redirect_uri=#{@redirect_uri}&response_type=code&client_id=#{@client_id}")
    end

    def request_access_token(authorisation_code:)
      uri = Rails.configuration.oauth[:token_uri]
      basic_auth = {
        username: Rails.configuration.oauth[:client_id],
        password: Rails.configuration.oauth[:secret],
      }
      body = {
        grant_type: "authorization_code",
        code: authorisation_code,
        redirect_uri: Rails.configuration.oauth[:redirect_uri],
      }

      HTTParty.post(uri, basic_auth: basic_auth, body: body)
    end

    def refresh_access_token(refresh_token:)
      uri = Rails.configuration.oauth[:token_uri]
      basic_auth = {
        username: Rails.configuration.oauth[:client_id],
        password: Rails.configuration.oauth[:secret],
      }
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
  end
end
