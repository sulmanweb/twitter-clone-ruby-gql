require 'rails_helper'

RSpec.describe Mutations::RemoveRetweet, type: :request do
  let(:user) { create(:user) }
  let(:tweet) { create(:tweet) }
  let(:query) do
    <<~GQL
      mutation RemoveRetweet($input: RemoveRetweetInput!) {
        removeRetweet(input: $input) {
          errors
          success
        }
      }
    GQL
  end
  let(:variables) do
    {
      input: {
        tweetId: tweet.id
      }
    }
  end
  let(:headers) { sign_in_test_headers(user.sessions.create!) }

  before { create(:retweet, tweet:, user:) }

  context 'when the user is valid' do
    it 'returns no errors' do
      post '/graphql', headers:, params: { query:, variables: variables.to_json }
      result = JSON.parse(response.body, symbolize_names: true)
      expect(result[:data][:removeRetweet][:errors]).to be_nil
    end

    it 'returns success' do
      post '/graphql', headers:, params: { query:, variables: variables.to_json }
      result = JSON.parse(response.body, symbolize_names: true)
      expect(result[:data][:removeRetweet][:success]).to be(true)
    end
  end

  context 'when the user is not signed in' do
    it 'returns errors' do
      post '/graphql', params: { query:, variables: variables.to_json }
      result = JSON.parse(response.body, symbolize_names: true)
      expect(result[:data][:removeRetweet][:errors]).to be_present
    end

    it 'returns not success' do
      post '/graphql', params: { query:, variables: variables.to_json }
      result = JSON.parse(response.body, symbolize_names: true)
      expect(result[:data][:removeRetweet][:success]).to be(false)
    end
  end
end
