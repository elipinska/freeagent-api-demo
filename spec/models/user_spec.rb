# frozen_string_literal: true
require "rails_helper"

RSpec.describe User, :type => :model do
  let(:user) { create(:user) }

  describe "associations" do
    it { is_expected.to have_one(:freeagent_api_authentication).dependent(:destroy) }
  end

  describe "attributes" do
    it "has all expected attributes" do
      expect(user).to have_attributes(
        email: /john.*@example.com/
      )
    end
  end
end
