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
require 'rails_helper'

RSpec.describe Tweet, type: :model do
  it 'has a valid factory' do
    expect(build(:tweet)).to be_valid
    expect(build(:tweet, :retweet)).to be_valid
    expect(build(:tweet, :empty_reply)).to be_valid
    expect(build(:tweet, :reply)).to be_valid
  end

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:text) }
  end

  it 'is not a reply by default' do
    expect(build(:tweet).reply?).to be false
  end

  it 'is a reply if it has a reply_to_tweet_id' do
    expect(build(:tweet, reply_to_tweet_id: 1)).to be_reply
  end

  it 'is not a retweet by default' do
    expect(build(:tweet).is_retweet?).to be false
  end

  it 'is a retweet if is_retweet is true' do
    expect(build(:tweet, is_retweet: true)).to be_is_retweet
  end

  it 'is not valid without text if it is not a retweet' do
    expect(build(:tweet, text: nil)).not_to be_valid
  end

  it 'is valid without text if it is a retweet' do
    expect(build(:tweet, text: nil, is_retweet: true)).to be_valid
  end
end
