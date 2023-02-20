require 'rails_helper'

RSpec.describe Tweets::DeleteService do
  describe '.call' do
    context 'when the user is valid' do
      let(:user) { create(:user) }
      let(:tweet) { create(:tweet, user:) }

      it 'returns no errors and success' do
        result = described_class.call(
          user:,
          tweet_id: tweet.id
        )

        expect(result.errors).to be_nil
        expect(result.success).to be(true)
      end
    end

    context 'when the user is invalid' do
      let(:tweet) { create(:tweet) }

      it 'returns errors and not success' do
        result = described_class.call(
          user: nil,
          tweet_id: tweet.id
        )

        expect(result.errors).to be_a(Array)
        expect(result.success).to be(false)
      end
    end

    context 'when the tweet is invalid' do
      let(:user) { create(:user) }

      it 'returns errors and not success' do
        result = described_class.call(
          user:,
          tweet_id: nil
        )

        expect(result.errors).to be_a(Array)
        expect(result.success).to be(false)
      end
    end
  end
end
