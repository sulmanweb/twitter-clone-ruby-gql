# == Schema Information
#
# Table name: likes
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  tweet_id   :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_likes_on_tweet_id              (tweet_id)
#  index_likes_on_user_id               (user_id)
#  index_likes_on_user_id_and_tweet_id  (user_id,tweet_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (tweet_id => tweets.id)
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Like, type: :model do
  it 'has a valid factory' do
    expect(build(:like)).to be_valid
  end

  it 'is invalid without a user' do
    expect(build(:like, user: nil)).not_to be_valid
  end

  it 'is invalid without a tweet' do
    expect(build(:like, tweet: nil)).not_to be_valid
  end

  it 'is invalid if the user has already liked the tweet' do
    user = create(:user)
    tweet = create(:tweet, user:)
    create(:like, user:, tweet:)
    expect(build(:like, user:, tweet:)).not_to be_valid
  end
end
