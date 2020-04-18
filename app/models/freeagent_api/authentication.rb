# frozen_string_literal: true
module FreeagentApi
  class Authentication < ApplicationRecord
    belongs_to :user
    validates :user, presence: true

    def update_access_token(params)
      raise "No new params have been given" if params.nil?
      new_params = params.symbolize_keys
      access_token = new_params.fetch(:access_token)
      expires_at = new_params[:expires_at] ? new_params[:expires_at] : (Time.zone.now + new_params.fetch(:expires_in))

      update(access_token: access_token, expires_at: expires_at)
    end
  end
end
