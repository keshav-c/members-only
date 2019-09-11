require 'test_helper'

class SessionManagementTest < ActionDispatch::IntegrationTest
  test 'invalid login' do
    get login_path
    post login_path, params: { session: { email: '', password: '' } }
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_url
    assert flash.empty?
  end

  test 'hide post author info with no login' do
    get posts_path
    assert_select 'a[href=?]', logout_path, count: 0
    assert_select 'a[href=?]', new_post_path, count: 0
    assert_select 'span[class=?]', 'known-user', count: 0
    assert_select 'span[class=?]', 'anon-user', count: 2
  end

  test 'doesn\'t allow to get new post page without login' do
    get new_post_path
    assert_redirected_to login_path
    follow_redirect!
    assert_select 'div[class=?]', 'flash-error'
  end

  test 'shows post author info with valid login' do
    get login_path
    post login_path, params: { session: { email: 'honey@hive.org',
                                          password: 'onlyeatsleep' } }
    assert_redirected_to root_url
    follow_redirect!
    assert_template 'static_pages/new'
    assert_select 'a[href=?]', logout_path
    assert_select 'h3'
    get new_post_path
    assert_template 'posts/new'
    assert_difference 'Post.count', 1 do
      post posts_path, params: { post: { content: 'A sample post.' } }
    end
    assert_redirected_to posts_path
    follow_redirect!
    assert_select 'a[href=?]', logout_path
    assert_select 'a[href=?]', new_post_path
    assert_select 'span[class=?]', 'known-user', count: 3
    assert_select 'span[class=?]', 'anon-user', count: 0
  end
end
