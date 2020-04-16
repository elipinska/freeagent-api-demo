require 'test_helper'

class FreeagentApi::AuthenticationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @freeagent_api_authentication = freeagent_api_authentications(:one)
  end

  test "should get index" do
    get freeagent_api_authentications_url
    assert_response :success
  end

  test "should get new" do
    get new_freeagent_api_authentication_url
    assert_response :success
  end

  test "should create freeagent_api_authentication" do
    assert_difference('FreeagentApi::Authentication.count') do
      post freeagent_api_authentications_url, params: { freeagent_api_authentication: {  } }
    end

    assert_redirected_to freeagent_api_authentication_url(FreeagentApi::Authentication.last)
  end

  test "should show freeagent_api_authentication" do
    get freeagent_api_authentication_url(@freeagent_api_authentication)
    assert_response :success
  end

  test "should get edit" do
    get edit_freeagent_api_authentication_url(@freeagent_api_authentication)
    assert_response :success
  end

  test "should update freeagent_api_authentication" do
    patch freeagent_api_authentication_url(@freeagent_api_authentication), params: { freeagent_api_authentication: {  } }
    assert_redirected_to freeagent_api_authentication_url(@freeagent_api_authentication)
  end

  test "should destroy freeagent_api_authentication" do
    assert_difference('FreeagentApi::Authentication.count', -1) do
      delete freeagent_api_authentication_url(@freeagent_api_authentication)
    end

    assert_redirected_to freeagent_api_authentications_url
  end
end
