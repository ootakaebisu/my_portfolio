require 'test_helper'

class TimeAttacksControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get time_attacks_new_url
    assert_response :success
  end

  test "should get index" do
    get time_attacks_index_url
    assert_response :success
  end

end
