require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get users_show_url
    assert_response :success
  end

  test "should get index" do
    get users_index_url
    assert_response :success
  end

  test "should get follow_users" do
    get users_follow_users_url
    assert_response :success
  end

  test "should get edit" do
    get users_edit_url
    assert_response :success
  end

  test "should get unsubscribe" do
    get users_unsubscribe_url
    assert_response :success
  end

  test "should get result" do
    get users_result_url
    assert_response :success
  end

  test "should get public" do
    get users_public_url
    assert_response :success
  end

end
