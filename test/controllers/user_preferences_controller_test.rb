require "test_helper"

class UserPreferencesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael) # User with preferences
    @other_user = users(:archer) # User with no preferences
  end

  test "GET /users/:user_id/preferences routes correctly" do
    get "/users/#{@user.id}/preferences"

    raw_json   = response.body
    status     = response.status
    parsed_json = JSON.parse(raw_json)

    assert_equal 200, status
    assert_equal 10, parsed_json["pagination"]
  end

  test "POST /users/:user_id/preferences routes correctly" do
    UserPreference::PAGINATION_OPTIONS.each do |pagination_option|
      post "/users/#{@other_user.id}/preferences", params: { preference: { pagination: pagination_option } }

      raw_json   = response.body
      status     = response.status
      parsed_json = JSON.parse(raw_json)

      assert_equal 200, status
      assert_equal pagination_option, parsed_json["pagination"]

      @other_user.reload
      assert_equal pagination_option, @other_user.preference.pagination
    end
  end
end
