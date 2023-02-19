require 'rails_helper'

RSpec.describe Mutations::CreateTweet, type: :request do
  let(:user) { create(:user) }
  let(:query) do
    <<~GQL
      mutation CreateTweet($input: CreateTweetInput!) {
        createTweet(input: $input) {
          errors
          tweet {
            id
          }
        }
      }
    GQL
  end
  let(:variables) do
    {
      input: {
        text: 'This is a tweet'
      }
    }
  end
  let(:headers) { sign_in_test_headers(user.sessions.create!) }

  context 'when the user is valid' do
    it 'returns the tweet' do
      post '/graphql', headers:, params: { query:, variables: variables.to_json }
      result = JSON.parse(response.body, symbolize_names: true)
      expect(result[:data][:createTweet][:tweet][:id]).to be_present
    end

    it 'returns no errors' do
      post '/graphql', headers:, params: { query:, variables: variables.to_json }
      result = JSON.parse(response.body, symbolize_names: true)
      expect(result[:data][:createTweet][:errors]).to be_nil
    end
  end

  context 'when the user is not signed in' do
    it 'returns no tweet' do
      post '/graphql', params: { query:, variables: variables.to_json }
      result = JSON.parse(response.body, symbolize_names: true)
      expect(result[:data][:createTweet][:tweet]).to be_nil
    end

    it 'returns errors' do
      post '/graphql', params: { query:, variables: variables.to_json }
      result = JSON.parse(response.body, symbolize_names: true)
      expect(result[:data][:createTweet][:errors]).to be_present
    end

    context 'when tweet text is too long' do
      let(:variables) do
        {
          input: {
            text: 'a' * 260
          }
        }
      end

      it 'returns no tweet' do
        post '/graphql', headers:, params: { query:, variables: variables.to_json }
        result = JSON.parse(response.body, symbolize_names: true)
        expect(result[:data][:createTweet][:tweet]).to be_nil
      end

      it 'returns errors' do
        post '/graphql', headers:, params: { query:, variables: variables.to_json }
        result = JSON.parse(response.body, symbolize_names: true)
        expect(result[:data][:createTweet][:errors]).to be_present
      end
    end
  end
end
