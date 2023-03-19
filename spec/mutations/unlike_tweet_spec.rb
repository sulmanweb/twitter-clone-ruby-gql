require 'rails_helper'

RSpec.describe Mutations::UnlikeTweet, type: :request do
  let(:user) { create(:user) }
  let(:query) do
    <<~GQL
      mutation UnlikeTweet($input: UnlikeTweetInput!) {
        unlikeTweet(input: $input) {
          errors
          tweet {
            id
          }
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
  let(:tweet) { create(:tweet) }

  before { tweet.likes.create!(user:) }

  context 'when the user is valid' do
    it 'returns the tweet' do
      post '/graphql', headers:, params: { query:, variables: variables.to_json }
      result = JSON.parse(response.body, symbolize_names: true)
      expect(result[:data][:unlikeTweet][:tweet][:id]).to be_present
    end

    it 'returns no errors' do
      post '/graphql', headers:, params: { query:, variables: variables.to_json }
      result = JSON.parse(response.body, symbolize_names: true)
      expect(result[:data][:unlikeTweet][:errors]).to be_nil
    end
  end

  context 'when the user is not signed in' do
    it 'returns no tweet' do
      post '/graphql', params: { query:, variables: variables.to_json }
      result = JSON.parse(response.body, symbolize_names: true)
      expect(result[:data][:unlikeTweet][:tweet]).to be_nil
    end

    it 'returns errors' do
      post '/graphql', params: { query:, variables: variables.to_json }
      result = JSON.parse(response.body, symbolize_names: true)
      expect(result[:data][:unlikeTweet][:errors]).to be_present
    end
  end

  context 'when the tweet is invalid' do
    let(:variables) do
      {
        input: {
          tweetId: 0
        }
      }
    end

    it 'returns no tweet' do
      post '/graphql', headers:, params: { query:, variables: variables.to_json }
      result = JSON.parse(response.body, symbolize_names: true)
      expect(result[:data][:unlikeTweet][:tweet]).to be_nil
    end

    it 'returns errors' do
      post '/graphql', headers:, params: { query:, variables: variables.to_json }
      result = JSON.parse(response.body, symbolize_names: true)
      expect(result[:data][:unlikeTweet][:errors]).to be_present
    end
  end

  context 'when the tweet is not liked' do
    before { tweet.likes.destroy_all }

    it 'returns no tweet' do
      post '/graphql', headers:, params: { query:, variables: variables.to_json }
      result = JSON.parse(response.body, symbolize_names: true)
      expect(result[:data][:unlikeTweet][:tweet]).to be_nil
    end

    it 'returns errors' do
      post '/graphql', headers:, params: { query:, variables: variables.to_json }
      result = JSON.parse(response.body, symbolize_names: true)
      expect(result[:data][:unlikeTweet][:errors]).to be_present
    end
  end
end
