require 'test_helper'

class RecordsControllerTest < ActionDispatch::IntegrationTest
  test "should get calendar" do
    get records_calendar_url
    assert_response :success
  end

  test "should get show" do
    get records_show_url
    assert_response :success
  end

end
