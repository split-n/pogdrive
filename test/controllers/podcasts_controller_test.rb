require 'test_helper'

class PodcastsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get podcasts_show_url
    assert_response :success
  end

end
