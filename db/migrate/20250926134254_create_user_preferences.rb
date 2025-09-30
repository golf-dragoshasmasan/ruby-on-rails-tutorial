class CreateUserPreferences < ActiveRecord::Migration[6.1]
  def up
    create_table :user_preferences do |t|
      t.references :user, null: false, foreign_key: true, index: { unique: true }
      t.integer :pagination, null: false, default: 25

      t.timestamps
    end

    # Add a database-level check constraint for allowed values
    add_index :user_preferences, :user_id, unique: true

    add_check_constraint :user_preferences,
                         "pagination IN (5, 10, 20, 25, 50, 100)",
                         name: "pagination_check"


    # Backfill existing users in bulk
    say_with_time "Backfilling user preferences for existing users" do
      now = Time.current
      rows = User.pluck(:id).map do |user_id|
        {
          user_id: user_id,
          pagination: 25,
          created_at: now,
          updated_at: now
        }
      end

      UserPreference.insert_all(rows)
    end

  end

  def down
    drop_table :user_preferences
  end
end
