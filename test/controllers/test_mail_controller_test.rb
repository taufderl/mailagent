require 'test_helper'

class TestMailControllerTest < ActionController::TestCase
  test "should get new:post" do
    get :new:post
    assert_response :success
  end

end
