require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest

  test "layout links" do
    get root_path
    assert_template "home/top"
    assert_select "a[href=?]", root_path
  end

end
