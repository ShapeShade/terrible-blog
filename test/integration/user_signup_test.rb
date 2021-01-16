require 'test_helper'

class UserSignupTest < ActionDispatch::IntegrationTest
  test 'get signup user form and create the user' do
    get signup_path
    assert_response :success
    assert_difference('User.count', 1) do
      post users_path, params: { user: { username: 'testuser', email: 'test@test.com', password: '1234' } }
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success
    assert_match('profile', response.body)
  end
end
