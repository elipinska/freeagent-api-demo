require "rails_helper"

RSpec.describe "Using requests", :type => :request do
  let(:user) { create(:user) }
  let(:api_request) { create(:request) }

  before do
    sign_in user
  end

  it "creates a Requests and redirects to the Requests's page" do
    get "/freeagent_api/requests/new"
    expect(response).to render_template(:new)
    expect(response).to render_template(partial: "_form")

    post "/freeagent_api/requests", params: {
      freeagent_api_request: {
        name: "List all invoices",
        endpoint: "/v2/invoices",
        method: "get",
        body: ""
      }
    }

    expect(response).to redirect_to(assigns(:freeagent_api_request))
    follow_redirect!

    expect(response).to render_template(:show)
    expect(response.body).to include("Request was successfully created.")
  end

  it "updates a Request" do
    api_request_id = api_request.id
    get "/freeagent_api/requests/#{api_request_id}/edit"
    expect(response).to render_template(:edit)
    expect(response).to render_template(partial: "_form")

    put "/freeagent_api/requests/#{api_request_id}", params: {
      freeagent_api_request: {
        method: "get",
        body: "{\"invoice\":{\"dated_on\":\"2020-02-12\",\"payment_terms_in_days\":30}}"
      }
    }

    expect(response).to redirect_to(assigns(:freeagent_api_request))
    follow_redirect!
    expect(response).to render_template(:show)
    expect(response.body).to include("Request was successfully updated.")
  end

  it "allows a user to delete a Request" do
    api_request_id = api_request.id
    get "/freeagent_api/requests"
    expect(response).to render_template(:index)
    delete "/freeagent_api/requests/#{api_request_id}"
    expect(response).to redirect_to("/freeagent_api/requests")
    follow_redirect!
    expect(response.body).to include("Request was successfully destroyed.")
  end

  it "allows a user to make a request" do
    response_body = { "user"=>
      {"url"=>"https://api.sandbox.freeagent.com/v2/users/2604",
       "first_name"=>"Ewa",
       "last_name"=>"Lipinska",
       "hidden"=>false,
       "email"=>"ewa.lipinska@freeagent.com",
       "role"=>"Director",
       "permission_level"=>8,
       "opening_mileage"=>"0.0",
       "updated_at"=>"2020-04-19T12:50:40.000Z",
       "created_at"=>"2019-03-14T12:40:19.000Z"
      }
    }.to_json

    stub_request(:get, "https://api.sandbox.freeagent.com/v2/users/me")
      .to_return(status: 200, body: response_body, headers: {})

    get_request = create(:request).tap do |request |
      request.endpoint = "v2/users/me"
      request.method = "get"
      request.body = ""
      request.save!
    end

    authentication = create(:authentication).tap do |auth|
      auth.user = user
      auth.save!
    end

    get "/freeagent_api/requests/#{get_request.id}"
    expect(response.body).to include("Send request")

    get "/freeagent_api/requests/#{get_request.id}/trigger"
    expect(response).to render_template(:trigger)
    expect(response.body).to include("API responded with status 200")
    expect(response.body).to include("<td>https://api.sandbox.freeagent.com/v2/users/2604</td>")
  end
end
