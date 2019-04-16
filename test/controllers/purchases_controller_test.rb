require 'test_helper'

class PurchasesControllerTest < ActionDispatch::IntegrationTest
  test "should get search" do
    get purchases_search_url
    assert_response :success
  end

end
