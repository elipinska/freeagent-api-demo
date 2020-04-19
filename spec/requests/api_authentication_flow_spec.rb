require "rails_helper"

RSpec.describe "API authentication flow", :type => :request do

  # it "creates a Widget and redirects to the Widget's page" do
  #   get "/widgets/new"
  #   expect(response).to render_template(:new)

  #   post "/widgets", :widget => {:name => "My Widget"}

  #   expect(response).to redirect_to(assigns(:widget))
  #   follow_redirect!

  #   expect(response).to render_template(:show)
  #   expect(response.body).to include("Widget was successfully created.")
  # end

  # it "does not render a different template" do
  #   get "/widgets/new"
  #   expect(response).to_not render_template(:show)
  # end

  # should redirect you to the authentication show view if you already have tokens
  # should allow you to refresh tokens
  # should take you to FreeAgent to initiate login (and then should redirect back and create a new authentication object)
end
