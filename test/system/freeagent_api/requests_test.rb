require "application_system_test_case"

class FreeagentApi::RequestsTest < ApplicationSystemTestCase
  setup do
    @freeagent_api_request = freeagent_api_requests(:one)
  end

  test "visiting the index" do
    visit freeagent_api_requests_url
    assert_selector "h1", text: "Freeagent Api/Requests"
  end

  test "creating a Request" do
    visit freeagent_api_requests_url
    click_on "New Freeagent Api/Request"

    fill_in "Endpoint", with: @freeagent_api_request.endpoint
    fill_in "Method", with: @freeagent_api_request.method
    click_on "Create Request"

    assert_text "Request was successfully created"
    click_on "Back"
  end

  test "updating a Request" do
    visit freeagent_api_requests_url
    click_on "Edit", match: :first

    fill_in "Endpoint", with: @freeagent_api_request.endpoint
    fill_in "Method", with: @freeagent_api_request.method
    click_on "Update Request"

    assert_text "Request was successfully updated"
    click_on "Back"
  end

  test "destroying a Request" do
    visit freeagent_api_requests_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Request was successfully destroyed"
  end
end
