# == Schema Information
#
# Table name: tweets
#
#  id                :bigint           not null, primary key
#  is_retweet        :boolean          default(FALSE)
#  text              :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  reply_to_tweet_id :bigint
#  user_id           :bigint           not null
#
# Indexes
#
#  index_tweets_on_reply_to_tweet_id  (reply_to_tweet_id)
#  index_tweets_on_user_id            (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Tweet < ApplicationRecord
  # @note: Associations
  belongs_to :user

  # @note: Validations
  validates :text, presence: true, unless: :is_retweet?

  # @note: The tweet is a reply if it has a reply_to_tweet_id
  # @return [Boolean]
  def reply?
    reply_to_tweet_id.present?
  end
end
