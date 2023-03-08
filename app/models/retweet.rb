# == Schema Information
#
# Table name: retweets
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  tweet_id   :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_retweets_on_tweet_id              (tweet_id)
#  index_retweets_on_user_id               (user_id)
#  index_retweets_on_user_id_and_tweet_id  (user_id,tweet_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (tweet_id => tweets.id)
#  fk_rails_...  (user_id => users.id)
#
class Retweet < ApplicationRecord
  # @note: Relationships
  belongs_to :user
  belongs_to :tweet

  # @note: Validations
  validates :tweet_id, uniqueness: { scope: :user_id }
  validate :tweet_user_id_cannot_be_equal_to_user_id

  # @note: This method is used to validate that the user_id is not equal to the tweet user_id
  def tweet_user_id_cannot_be_equal_to_user_id
    errors.add(:user_id, 'cannot be equal to tweet user id') if user_id == Tweet.find_by(id: tweet_id)&.user_id
  end
end
