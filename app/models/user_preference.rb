class UserPreference < ApplicationRecord
  belongs_to :user

  PAGINATION_OPTIONS = [5, 10, 20, 25, 50, 100].freeze
  PAGINATION_DEFAULT = 25

  validates :pagination, inclusion: { in: PAGINATION_OPTIONS }

  # Fully explicit creation method
  def self.create_for_user!(user, pagination: PAGINATION_DEFAULT)
    pref = new(
      user_id: user.id,
      pagination: pagination
    )
    pref.save!
    pref
  end
end
