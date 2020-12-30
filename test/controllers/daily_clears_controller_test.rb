require 'test_helper'

class DailyClearsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get daily_clears_show_url
    assert_response :success
  end

end
