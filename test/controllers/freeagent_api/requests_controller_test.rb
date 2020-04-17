require 'test_helper'

class FreeagentApi::RequestsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @freeagent_api_request = freeagent_api_requests(:one)
  end

  test "should get index" do
    get freeagent_api_requests_url
    assert_response :success
  end

  test "should get new" do
    get new_freeagent_api_request_url
    assert_response :success
  end

  test "should create freeagent_api_request" do
    assert_difference('FreeagentApi::Request.count') do
      post freeagent_api_requests_url, params: { freeagent_api_request: { endpoint: @freeagent_api_request.endpoint, method: @freeagent_api_request.method } }
    end

    assert_redirected_to freeagent_api_request_url(FreeagentApi::Request.last)
  end

  test "should show freeagent_api_request" do
    get freeagent_api_request_url(@freeagent_api_request)
    assert_response :success
  end

  test "should get edit" do
    get edit_freeagent_api_request_url(@freeagent_api_request)
    assert_response :success
  end

  test "should update freeagent_api_request" do
    patch freeagent_api_request_url(@freeagent_api_request), params: { freeagent_api_request: { endpoint: @freeagent_api_request.endpoint, method: @freeagent_api_request.method } }
    assert_redirected_to freeagent_api_request_url(@freeagent_api_request)
  end

  test "should destroy freeagent_api_request" do
    assert_difference('FreeagentApi::Request.count', -1) do
      delete freeagent_api_request_url(@freeagent_api_request)
    end

    assert_redirected_to freeagent_api_requests_url
  end
end
