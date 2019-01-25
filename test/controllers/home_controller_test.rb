require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest

  def setup
    @base_title = "SheetShare"
  end

  test "should get root" do
    get root_url
    assert_response :success
    assert_select "title", "Top | #{@base_title}"
  end

end
