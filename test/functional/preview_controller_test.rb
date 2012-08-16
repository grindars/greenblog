require 'test_helper'

class PreviewControllerTest < ActionController::TestCase
  test "should get convert" do
    get :convert
    assert_response :success
  end

end
