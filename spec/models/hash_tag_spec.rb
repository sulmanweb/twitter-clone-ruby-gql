# == Schema Information
#
# Table name: hash_tags
#
#  id         :bigint           not null, primary key
#  tag        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  tweet_id   :bigint           not null
#
# Indexes
#
#  index_hash_tags_on_tweet_id          (tweet_id)
#  index_hash_tags_on_tweet_id_and_tag  (tweet_id,tag) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (tweet_id => tweets.id)
#
require 'rails_helper'

RSpec.describe HashTag, type: :model do
  it 'has a valid factory' do
    expect(build(:hash_tag)).to be_valid
  end

  it 'is invalid without a tweet' do
    expect(build(:hash_tag, tweet: nil)).not_to be_valid
  end

  it 'is invalid without a tag' do
    expect(build(:hash_tag, tag: nil)).not_to be_valid
  end

  it 'is invalid with a duplicate tag scoped to tweet' do
    hash_tag = create(:hash_tag, tag: 'test')
    expect(build(:hash_tag, tag: 'test', tweet: hash_tag.tweet)).not_to be_valid
  end
end
