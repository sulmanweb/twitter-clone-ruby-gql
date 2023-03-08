require 'rails_helper'

RSpec.describe Mutations::CreateRetweet, type: :request do
  let(:user) { create(:user) }
  let(:query) do
    <<~GQL
      mutation CreateRetweet($input: CreateRetweetInput!) {
        createRetweet(input: $input) {
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
        tweetId: create(:tweet).id
      }
    }
  end
  let(:headers) { sign_in_test_headers(user.sessions.create!) }

  context 'when the user is valid' do
    it 'returns the tweet' do
      post '/graphql', headers:, params: { query:, variables: variables.to_json }
      result = JSON.parse(response.body, symbolize_names: true)
      expect(result[:data][:createRetweet][:tweet][:id]).to be_present
    end

    it 'returns no errors' do
      post '/graphql', headers:, params: { query:, variables: variables.to_json }
      result = JSON.parse(response.body, symbolize_names: true)
      expect(result[:data][:createRetweet][:errors]).to be_nil
    end

    it 'returns success' do
      post '/graphql', headers:, params: { query:, variables: variables.to_json }
      result = JSON.parse(response.body, symbolize_names: true)
      expect(result[:data][:createRetweet][:success]).to be(true)
    end
  end

  context 'when the user is not signed in' do
    it 'returns no tweet' do
      post '/graphql', params: { query:, variables: variables.to_json }
      result = JSON.parse(response.body, symbolize_names: true)
      expect(result[:data][:createRetweet][:tweet]).to be_nil
    end

    it 'returns errors' do
      post '/graphql', params: { query:, variables: variables.to_json }
      result = JSON.parse(response.body, symbolize_names: true)
      expect(result[:data][:createRetweet][:errors]).to be_present
    end

    it 'returns not success' do
      post '/graphql', params: { query:, variables: variables.to_json }
      result = JSON.parse(response.body, symbolize_names: true)
      expect(result[:data][:createRetweet][:success]).to be(false)
    end
  end

  context 'when tweet is not found' do
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
      expect(result[:data][:createRetweet][:tweet]).to be_nil
    end

    it 'returns errors' do
      post '/graphql', headers:, params: { query:, variables: variables.to_json }
      result = JSON.parse(response.body, symbolize_names: true)
      expect(result[:data][:createRetweet][:errors]).to be_present
    end

    it 'returns not success' do
      post '/graphql', headers:, params: { query:, variables: variables.to_json }
      result = JSON.parse(response.body, symbolize_names: true)
      expect(result[:data][:createRetweet][:success]).to be(false)
    end
  end

  context 'when tweet is already retweeted' do
    let(:tweet) { create(:tweet) }
    let(:variables) do
      {
        input: {
          tweetId: tweet.id
        }
      }
    end

    before do
      create(:retweet, user:, tweet:)
    end

    it 'returns no tweet' do
      post '/graphql', headers:, params: { query:, variables: variables.to_json }
      result = JSON.parse(response.body, symbolize_names: true)
      expect(result[:data][:createRetweet][:tweet]).to be_nil
    end

    it 'returns errors' do
      post '/graphql', headers:, params: { query:, variables: variables.to_json }
      result = JSON.parse(response.body, symbolize_names: true)
      expect(result[:data][:createRetweet][:errors]).to be_present
    end

    it 'returns not success' do
      post '/graphql', headers:, params: { query:, variables: variables.to_json }
      result = JSON.parse(response.body, symbolize_names: true)
      expect(result[:data][:createRetweet][:success]).to be(false)
    end
  end
end
