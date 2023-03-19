require 'rails_helper'

RSpec.describe Tweets::AddHashTagsForTweet do
  let(:tweet) { create(:tweet, text: 'Hello #World! What are you doing @sulmanweb') }

  it 'adds hash tags for tweet' do
    described_class.call(tweet:)
    hash_tags = tweet.hash_tags.pluck(:tag)

    expect(hash_tags.count).to eq(1)
    expect(hash_tags).to eq(['World'])
  end

  context 'when tweet has no hash tags' do
    let(:tweet) { create(:tweet, text: 'Hello World! What are you doing @sulmanweb') }

    it 'does not add hash tags for tweet' do
      described_class.call(tweet:)
      hash_tags = tweet.hash_tags.pluck(:tag)

      expect(hash_tags.count).to eq(0)
    end
  end

  context 'when tweet has duplicate hash tags' do
    let(:tweet) { create(:tweet, text: 'Hello #World! What are you doing @sulmanweb #World') }

    it 'does not add duplicate hash tags for tweet' do
      described_class.call(tweet:)
      hash_tags = tweet.hash_tags.pluck(:tag)

      expect(hash_tags.count).to eq(1)
      expect(hash_tags).to eq(['World'])
    end
  end
end
