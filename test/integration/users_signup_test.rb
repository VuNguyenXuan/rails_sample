require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test 'invalid sign up information' do
    get signup_path
    # the below same this ``` before_count = User.count; post users_path ......; after_count = User.count; assert_equal before_count after_count```
    assert_no_difference 'User.count' do
      post users_path, params: {user: {name: "", email: "invalid", password: "foo", password_confirmation: "bar"}}
    end
    assert_template 'users/new'
  end

  test "valid signup information" do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { name:  "Example User",
                                         email: "user@example.com",
                                         password:              "password",
                                         password_confirmation: "password" } }
    end
    follow_redirect!
    assert_template 'users/show'
  end
end
