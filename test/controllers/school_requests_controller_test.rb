require 'test_helper'

class SchoolRequestsControllerTest < ActionController::TestCase
  setup do
    @school_request = school_requests(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:school_requests)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create school_request" do
    assert_difference('SchoolRequest.count') do
      post :create, school_request: { number_requests: @school_request.number_requests, school_name: @school_request.school_name, user_id: @school_request.user_id }
    end

    assert_redirected_to school_request_path(assigns(:school_request))
  end

  test "should show school_request" do
    get :show, id: @school_request
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @school_request
    assert_response :success
  end

  test "should update school_request" do
    patch :update, id: @school_request, school_request: { number_requests: @school_request.number_requests, school_name: @school_request.school_name, user_id: @school_request.user_id }
    assert_redirected_to school_request_path(assigns(:school_request))
  end

  test "should destroy school_request" do
    assert_difference('SchoolRequest.count', -1) do
      delete :destroy, id: @school_request
    end

    assert_redirected_to school_requests_path
  end
end
