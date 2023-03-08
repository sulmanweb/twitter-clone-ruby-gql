# @note: This migration is for the retweets table
class CreateRetweets < ActiveRecord::Migration[7.0]
  def change
    create_table :retweets do |t|
      t.references :user, null: false, foreign_key: true
      t.references :tweet, null: false, foreign_key: true

      t.timestamps
    end
    add_index :retweets, [:user_id, :tweet_id], unique: true
  end
end
