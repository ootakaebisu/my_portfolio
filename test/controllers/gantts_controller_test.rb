require 'test_helper'

class GanttsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get gantts_show_url
    assert_response :success
  end

  test "should get edit" do
    get gantts_edit_url
    assert_response :success
  end

end
