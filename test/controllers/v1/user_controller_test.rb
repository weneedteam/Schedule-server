require 'test_helper'

class V1::UserControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
