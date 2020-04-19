# frozen_string_literal: true
require "rails_helper"

RSpec.describe FreeagentApi::Client, :type => :model do
  let(:api_client) { described_class.new }

  describe "#authorize_url" do
    it "returns a link to the OAuth Authorization Endpoint with correct parameters" do
      base_uri = "https://api.sandbox.freeagent.com/v2/approve_app"

      expect(api_client.authorize_url).to eq(
        URI(base_uri + "?redirect_uri=https://test_redirect_url.com&response_type=code&client_id=test_client_id")
      )
    end
  end
end
