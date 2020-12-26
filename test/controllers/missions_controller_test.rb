require 'test_helper'

class MissionsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get missions_new_url
    assert_response :success
  end

  test "should get result" do
    get missions_result_url
    assert_response :success
  end

  test "should get show" do
    get missions_show_url
    assert_response :success
  end

  test "should get edit" do
    get missions_edit_url
    assert_response :success
  end

  test "should get daily_clear" do
    get missions_daily_clear_url
    assert_response :success
  end

  test "should get complete" do
    get missions_complete_url
    assert_response :success
  end

end
