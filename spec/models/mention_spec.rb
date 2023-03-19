# == Schema Information
#
# Table name: mentions
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  tweet_id   :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_mentions_on_tweet_id              (tweet_id)
#  index_mentions_on_user_id               (user_id)
#  index_mentions_on_user_id_and_tweet_id  (user_id,tweet_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (tweet_id => tweets.id)
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Mention, type: :model do
  it 'has a valid factory' do
    expect(build(:mention)).to be_valid
  end

  it 'is invalid without a user' do
    expect(build(:mention, user: nil)).not_to be_valid
  end

  it 'is invalid without a tweet' do
    expect(build(:mention, tweet: nil)).not_to be_valid
  end

  it 'is invalid with a duplicate user and tweet' do
    mention = create(:mention)
    expect(build(:mention, user: mention.user, tweet: mention.tweet)).not_to be_valid
  end
end
