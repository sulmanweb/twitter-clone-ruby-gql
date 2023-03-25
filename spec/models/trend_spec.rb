# == Schema Information
#
# Table name: trends
#
#  id          :bigint           not null, primary key
#  name        :string
#  tweet_count :bigint
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_trends_on_name         (name)
#  index_trends_on_tweet_count  (tweet_count)
#
require 'rails_helper'

RSpec.describe Trend, type: :model do
  it 'is valid with valid attributes' do
    trend = described_class.new(name: 'test', tweet_count: 1)
    expect(trend).to be_valid
  end

  it 'is not valid without a name' do
    trend = described_class.new(tweet_count: 1)
    expect(trend).not_to be_valid
  end

  it 'is not valid without a tweet_count' do
    trend = described_class.new(name: 'test')
    expect(trend).not_to be_valid
  end

  it 'has a valid factory' do
    expect(build(:trend)).to be_valid
  end
end
