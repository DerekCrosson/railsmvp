require 'test_helper'

class V1::Resources::UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test "should return all users" do
    get v1_resources_users_all_url
    assert_response :success
  end

  test "should return a single user" do
    get v1_resources_users_url(@user.username)
    assert_response :success
  end

  test "should create a user" do
    assert_difference('User.count') do
      post v1_resources_users_new_url, params: { user: { email: 'new@example.com', encrypted_password: @user.encrypted_password, reset_password_token: @user.reset_password_token, reset_password_sent_at: @user.reset_password_sent_at, remember_created_at: @user.remember_created_at, sign_in_count: @user.sign_in_count, current_sign_in_at: @user.current_sign_in_at, last_sign_in_at: @user.last_sign_in_at, current_sign_in_ip: @user.current_sign_in_ip, last_sign_in_ip: @user.last_sign_in_ip, confirmation_token: @user.confirmation_token, confirmed_at: @user.confirmed_at, confirmation_sent_at: @user.confirmation_sent_at, unconfirmed_email: @user.unconfirmed_email, failed_attempts: @user.failed_attempts, unlock_token: @user.unlock_token, locked_at: @user.locked_at, created_at: @user.created_at, updated_at: @user.updated_at, username: 'new-user' } }
    end
    
    assert_redirected_to v1_resources_users_url(username: @user.username)
  end

  test "should update multiple columns for a single user" do
    put v1_resources_users_url(@user.username), params: { user: { email: @user.email, username: @user.username } }
    assert_redirected_to v1_resources_users_url(username: @user.username)
  end

  test "should update a single column for a single user" do
    patch v1_resources_users_url(@user.username), params: { user: { email: @user.email } }
    assert_redirected_to v1_resources_users_url(username: @user.username)
  end

  test "should delete a single user" do
    assert_difference('User.count', -1) do
      delete v1_resources_users_url(@user.username)
    end
    
    assert_redirected_to v1_resources_users_all_url
  end
end
