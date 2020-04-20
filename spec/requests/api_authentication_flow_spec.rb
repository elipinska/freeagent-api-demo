require "rails_helper"

RSpec.describe "API authentication flow", :type => :request do
  let(:user) { create(:user) }

  before do
    sign_in user
  end

  context "when the user already has an access token" do
    let!(:authentication) {
      create(:authentication).tap do |auth|
        auth.user = user
        auth.save!
      end
    }

    it "they cannot go through the authenticate flow again" do
      get "/freeagent_api/authentications/new"
      expect(response).not_to render_template(:new)
      expect(response).to redirect_to("/freeagent_api/authentications/#{authentication.id}")
      follow_redirect!

      expect(response).to render_template(:show)
      expect(response.body).to include("Looks like you already have access to the API!")
    end

    it "allows the user to refresh their access token" do
      get "/freeagent_api/authentications/#{authentication.id}"
      expect(response.body).to include("Renew access token")

      response_body = {
        "access_token":"2YotnFZFEjr1zCsicMWpAA",
        "token_type":"bearer",
        "expires_in":604800,
      }.to_json

      stub_request(:post, "https://api.sandbox.freeagent.com/v2/token_endpoint")
        .with(
          body: "grant_type=refresh_token&refresh_token=1tL2_xBH6MN0vOma4LhItirikijpVOP5OwB5PmRF9",
          headers: {
          'Authorization'=>'Basic dGVzdF9jbGllbnRfaWQ6dGVzdF9jbGllbnRfc2VjcmV0',
          })
        .to_return(status: 200, body: response_body, headers: {"Content-Type"=> "application/json"})

      put "/freeagent_api/authentications/#{authentication.id}"
      expect(response).to redirect_to(assigns(:freeagent_api_authentication))
      follow_redirect!
      expect(response.body).to include("Access token was successfully updated.")
    end
  end

  context "when the user doesn't have an access token" do
    it "contains a link to the authorization endpoint of the FreeAgent API on the root page" do
      get "/"
      expect(response).to render_template(:new)
      expect(response.body).to include("https://api.sandbox.freeagent.com/v2/approve_app?redirect_uri=https://test_redirect_url.com&amp;response_type=code&amp;client_id=test_client_id")
    end

    it "allows the user to create new authentication details" do
      response_body = {
        "access_token":"2YotnFZFEjr1zCsicMWpAA",
        "token_type":"bearer",
        "expires_in": 604800,
        "refresh_token":"tGzv3JOkF0XG5Qx2TlKWIA",
      }.to_json

      stub_request(:post, "https://api.sandbox.freeagent.com/v2/token_endpoint")
        .with(
          body: "grant_type=authorization_code&code=&redirect_uri=https%3A%2F%2Ftest_redirect_url.com",
          headers: {
          'Authorization'=>'Basic dGVzdF9jbGllbnRfaWQ6dGVzdF9jbGllbnRfc2VjcmV0',
          })
        .to_return(status: 200, body: response_body)

      post "/freeagent_api/authentications"
      expect(response).to redirect_to(assigns(:freeagent_api_authentication))
      follow_redirect!
      expect(response.body).to include("You&#39;ve successfully authenticated with FreeAgent!")
    end

    it "shows an error message if authentication was unsuccessful" do
      stub_request(:post, "https://api.sandbox.freeagent.com/v2/token_endpoint")
        .with(
          body: "grant_type=authorization_code&code=&redirect_uri=https%3A%2F%2Ftest_redirect_url.com",
          headers: {
          'Authorization'=>'Basic dGVzdF9jbGllbnRfaWQ6dGVzdF9jbGllbnRfc2VjcmV0',
          })
        .to_return(status: 400)

      post "/freeagent_api/authentications"
      expect(response).to redirect_to("/freeagent_api/authentications/new")
      follow_redirect!
      expect(response.body).to include("Something went wrong... Better luck next time!")
    end
  end
end
