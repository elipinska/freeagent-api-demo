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

  describe "#request_access_token" do
    it "exchanges an authorization code for access token" do
      response_body = {
        "access_token":"2YotnFZFEjr1zCsicMWpAA",
        "token_type":"bearer",
        "expires_in":604800,
        "refresh_token":"tGzv3JOkF0XG5Qx2TlKWIA",
      }.to_s

      stub_request(:post, "https://api.sandbox.freeagent.com/v2/token_endpoint")
        .with(
          body: "grant_type=authorization_code&code=abcdedfh&redirect_uri=https%3A%2F%2Ftest_redirect_url.com",
          headers: {
            'Authorization'=>'Basic dGVzdF9jbGllbnRfaWQ6dGVzdF9jbGllbnRfc2VjcmV0'
          }
        ).to_return(status: 200, body: response_body)

        expect(api_client.request_access_token(authorisation_code: "abcdedfh").code).to eq(200)
    end
  end

  describe "#refresh_access_token" do
    it "retrieves a new access token" do
      response_body = {
        "access_token":"2YotnFZFEjr1zCsicMWpAA",
        "token_type":"bearer",
        "expires_in":604800,
       }.to_s

      stub_request(:post, "https://api.sandbox.freeagent.com/v2/token_endpoint")
        .with(
          body: "grant_type=refresh_token&refresh_token=abcdedfh",
          headers: {
            'Authorization'=>'Basic dGVzdF9jbGllbnRfaWQ6dGVzdF9jbGllbnRfc2VjcmV0'
          }
        ).to_return(status: 200, body: response_body)

        expect(api_client.refresh_access_token(refresh_token: "abcdedfh").code).to eq(200)
    end
  end

  describe "#send_request" do
    let(:authentication) { create(:authentication) }
    let(:request) { create(:request) }

    it "sends the request with the access token in the header and correct parameters" do
      stub_request(:post, "https://api.sandbox.freeagent.com//v2/invoices")
        .with(
          body: "invoice[contact]=https%3A%2F%2Fapi.freeagent.com%2Fv2%2Fcontacts%2F%3CCONTACT_ID%3E&invoice[dated_on]=2019-12-12&invoice[payment_terms_in_days]=30",
          headers: {'Authorization'=>'Bearer 1rYYZLcKnutsIt2ETdP3zxEC0X8Xr9Geby934_O5B'})
        .to_return(status: 201, body: "", headers: {})

        expect(api_client.send_request(authentication: authentication, request: request).code).to eq(201)
    end
  end

  describe "#parse_body" do
    context "when the response contains a body" do
      it "returns request/response body as a hash" do
        response_body = {"contact"=>
          {"url"=>"https://api.sandbox.freeagent.com/v2/contacts/80908",
           "organisation_name"=>"Incredible Hikes",
           "first_name"=>"Bobby",
           "last_name"=>"Dawkins",
           "active_projects_count"=>0,
           "created_at"=>"2020-01-16T17:27:02.000Z",
           "updated_at"=>"2020-02-03T09:49:34.000Z",
           "contact_name_on_invoices"=>true,
           "country"=>"United Kingdom",
           "charge_sales_tax"=>"Auto",
           "locale"=>"en",
           "account_balance"=>"-90.0",
           "status"=>"Active",
           "uses_contact_invoice_sequence"=>false,
           "emails_invoices_automatically"=>false,
           "emails_payment_reminders"=>false,
           "emails_thank_you_notes"=>false,
           "uses_contact_level_email_settings"=>false}}.to_json

        response_stub = stub = double("response")
        allow(response_stub).to receive(:body).and_return(response_body)

        expect(api_client.parsed_body(message: response_stub)).to be_instance_of(Hash)
      end
    end

    context "when the response body is empty" do
      it "returns nil" do
        response_stub = stub = double("response")
        allow(response_stub).to receive(:body).and_return("")

        expect(api_client.parsed_body(message: response_stub)).to be_nil
      end
    end
  end
end
