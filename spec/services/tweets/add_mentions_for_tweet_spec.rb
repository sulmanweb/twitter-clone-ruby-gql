require 'rails_helper'

RSpec.describe Tweets::AddMentionsForTweet do
  describe '#call' do
    let(:user) { create(:user) }
    let(:tweet) { create(:tweet, text: "Hello World! @#{user.username}! How are you?") }

    it 'adds mention for tweet' do
      described_class.call(tweet:)

      expect(tweet.mentions.count).to eq(1)
      expect(tweet.mentions.first.user).to eq(user)
    end

    it 'does not add mention for tweet' do
      tweet = create(:tweet, text: 'Hello World! How are you?')
      described_class.call(tweet:)

      expect(tweet.mentions.count).to eq(0)
    end
  end
end
