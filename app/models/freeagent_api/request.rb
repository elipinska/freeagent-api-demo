# frozen_string_literal: true
class FreeagentApi::Request < ApplicationRecord
  validates :endpoint, presence: true
  validates :method, presence: true
end
