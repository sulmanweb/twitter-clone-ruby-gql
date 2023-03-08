require 'rails_helper'

RSpec.describe Tweets::CreateRetweetService do
  describe '.call' do
    context 'when the user is valid' do
      let(:user) { create(:user) }

      it 'returns a tweet, no errors and success' do
        result = described_class.call(
          tweet_id: create(:tweet).id,
          user:
        )

        expect(result.tweet).to be_a(Tweet)
        expect(result.errors).to be_nil
        expect(result.success).to be(true)
      end
    end

    context 'when the user is invalid' do
      it 'returns no tweet, errors and not success' do
        result = described_class.call(
          tweet_id: create(:tweet).id,
          user: nil
        )

        expect(result.tweet).to be_nil
        expect(result.errors).to be_a(Array)
        expect(result.success).to be(false)
      end
    end

    context 'when the tweet is invalid' do
      let(:user) { create(:user) }

      it 'returns no tweet, errors and not success' do
        result = described_class.call(
          tweet_id: nil,
          user:
        )

        expect(result.tweet).to be_nil
        expect(result.errors).to be_a(Array)
        expect(result.success).to be(false)
      end
    end

    context 'when user already retweeted the tweet' do
      let(:user) { create(:user) }
      let(:tweet) { create(:tweet) }

      before do
        create(:retweet, tweet:, user:)
      end

      it 'returns no tweet, errors and not success' do
        result = described_class.call(
          tweet_id: tweet.id,
          user:
        )

        expect(result.tweet).to be_nil
        expect(result.errors).to be_a(Array)
        expect(result.success).to be(false)
      end
    end
  end
end
