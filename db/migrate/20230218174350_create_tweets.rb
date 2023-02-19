# Purpose: Create the tweets table
class CreateTweets < ActiveRecord::Migration[7.0]
  def change
    create_table :tweets do |t|
      t.references :user, null: false, foreign_key: true
      t.string :text
      t.bigint :reply_to_tweet_id
      t.boolean :is_retweet, default: false

      t.timestamps
    end
    add_index :tweets, :reply_to_tweet_id
  end
end
