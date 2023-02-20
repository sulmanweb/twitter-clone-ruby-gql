require 'rails_helper'

RSpec.describe Mutations::DeleteTweet, type: :request do
  describe '.resolve' do
    let(:user) { create(:user) }
    let(:tweet) { create(:tweet, user:) }

    context 'when the user is valid' do
      it 'returns no errors and success' do
        post '/graphql', params: { query: query(tweet_id: tweet.id) }, headers: sign_in_test_headers(user.sessions.create!)

        json = JSON.parse(response.body)
        data = json['data']['deleteTweet']

        expect(data['errors']).to be_nil
        expect(data['success']).to be_truthy
      end
    end

    context 'when the user is invalid' do
      it 'returns errors and not success' do
        post '/graphql', params: { query: query(tweet_id: tweet.id) }

        json = JSON.parse(response.body)
        data = json['data']['deleteTweet']

        expect(data['errors']).to be_a(Array)
        expect(data['success']).to be(false)
      end
    end

    context 'when the tweet is invalid' do
      it 'returns errors and not success' do
        post '/graphql', params: { query: query(tweet_id: 0) }, headers: sign_in_test_headers(user.sessions.create!)

        json = JSON.parse(response.body)
        data = json['data']['deleteTweet']

        expect(data['errors']).to be_a(Array)
        expect(data['success']).to be(false)
      end
    end
  end

  def query(tweet_id:)
    <<~GQL
      mutation {
        deleteTweet(input: {tweetId: #{tweet_id}}) {
          errors
          success
        }
      }
    GQL
  end
end
