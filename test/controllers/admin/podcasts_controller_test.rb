require 'test_helper'

class Admin::PodcastsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @podcast = podcasts(:one)
  end

  test "should get index" do
    get admin_podcasts_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_podcast_url
    assert_response :success
  end

  test "should create podcast" do
    assert_difference('Podcast.count') do
      post admin_podcasts_url, params: { podcast: { max_count: @podcast.max_count, order_by: @podcast.order_by, query: @podcast.query, title: @podcast.title } }
    end

    assert_redirected_to admin_podcast_url(Podcast.last)
  end

  test "should show podcast" do
    get admin_podcast_url(@podcast)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_podcast_url(@podcast)
    assert_response :success
  end

  test "should update podcast" do
    patch admin_podcast_url(@podcast), params: { podcast: { max_count: @podcast.max_count, order_by: @podcast.order_by, query: @podcast.query, title: @podcast.title } }
    assert_redirected_to admin_podcast_url(@podcast)
  end

  test "should destroy podcast" do
    assert_difference('Podcast.count', -1) do
      delete admin_podcast_url(@podcast)
    end

    assert_redirected_to admin_podcasts_url
  end
end
