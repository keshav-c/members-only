require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test 'incorrect signup info' do
    get new_user_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: { name: '',
                                         email: 'hello',
                                         password: 'foo',
                                         password_confirmation: 'bar' } }
    end
    assert_template 'users/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  test 'correct signup info' do
    get new_user_path
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { name: 'Test',
                                         email: 'Test@blah.com',
                                         password: 'ax23wer',
                                         password_confirmation: 'ax23wer' } }
    end
    assert_redirected_to root_url
    follow_redirect!
    assert_template 'static_pages/new'
    assert_select 'a[href=?]', logout_path
    assert_select 'h3', class: 'welcome-message'
  end
end
