# @note: This migration is for the many-to-many relationship between users and tweets
class CreateMentions < ActiveRecord::Migration[7.0]
  def change
    create_table :mentions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :tweet, null: false, foreign_key: true

      t.timestamps
    end
    add_index :mentions, [:user_id, :tweet_id], unique: true
  end
end
