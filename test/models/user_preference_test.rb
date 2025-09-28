require "test_helper"

class UserPreferenceTest < ActiveSupport::TestCase
  def setup
    @user = users(:michael)
  end

  test "pagination preferences should not be outside the allowed values" do
    assert_raises(ActiveRecord::RecordInvalid) do
      @user.preference[:pagination] = 1337
      @user.preference.save!
    end
  end
end
