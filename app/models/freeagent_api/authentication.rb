# frozen_string_literal: true
module FreeagentApi
  class Authentication < ApplicationRecord
    belongs_to :user
    validates :user, presence: true
  end
end
