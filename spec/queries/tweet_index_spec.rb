require 'rails_helper'

RSpec.describe Queries::TweetIndex, type: :request do
  let(:query) do
    <<~GQL
      query($userId: ID, $first: Int, $query: String) {
        tweetIndex(userId: $userId, query: $query) {
          errors
          success
          tweets(first: $first) {
            nodes {
              id
              text
              user {
                id
                email
                username
              }
            }
          }
        }
      }
    GQL
  end

  let(:user1) { create(:user) }
  let(:user2) { create(:user) }
  let(:variables) { { userId: user_id, first:, query: nil } }

  before do
    create_list(:tweet, 10, user: user1)
    create_list(:tweet, 10, user: user2)
  end

  context 'when the user is not specified' do # rubocop:disable RSpec/MultipleMemoizedHelpers
    let(:user_id) { nil }
    let(:first) { 5 }

    it 'returns all tweets' do
      post('/graphql', params: { query:, variables: variables.to_json })
      result = JSON.parse(response.body, symbolize_names: true)

      expect(result[:data][:tweetIndex][:errors]).to be_nil
      expect(result[:data][:tweetIndex][:success]).to be_truthy
      expect(result[:data][:tweetIndex][:tweets][:nodes].count).to eq(5)
    end
  end

  context 'when the user is specified' do # rubocop:disable RSpec/MultipleMemoizedHelpers
    let(:user_id) { user1.id }
    let(:first) { 5 }

    it 'returns all tweets of user' do
      post('/graphql', params: { query:, variables: variables.to_json })
      result = JSON.parse(response.body, symbolize_names: true)

      expect(result[:data][:tweetIndex][:errors]).to be_nil
      expect(result[:data][:tweetIndex][:success]).to be_truthy
      expect(result[:data][:tweetIndex][:tweets][:nodes].count).to eq(5)
      expect(result[:data][:tweetIndex][:tweets][:nodes].first[:user][:id]).to eq(user1.id.to_s)
    end
  end

  context 'when the query is specified' do
    before do
      create_list(:tweet, 10, text: 'tweet')
    end

    let(:variables) { { userId: nil, first: 5, query: 'tweet' } }

    it 'returns all tweets that match the query' do
      post('/graphql', params: { query:, variables: variables.to_json })
      result = JSON.parse(response.body, symbolize_names: true)

      expect(result[:data][:tweetIndex][:errors]).to be_nil
      expect(result[:data][:tweetIndex][:success]).to be_truthy
      expect(result[:data][:tweetIndex][:tweets][:nodes].count).to eq(5)
    end
  end

  context 'when the query and user are specified' do
    before do
      create_list(:tweet, 10, text: 'tweet', user: user1)
    end

    let(:variables) { { userId: user1.id, first: 5, query: 'tweet' } }

    it 'returns all tweets that match the query' do
      post('/graphql', params: { query:, variables: variables.to_json })
      result = JSON.parse(response.body, symbolize_names: true)

      expect(result[:data][:tweetIndex][:errors]).to be_nil
      expect(result[:data][:tweetIndex][:success]).to be_truthy
      expect(result[:data][:tweetIndex][:tweets][:nodes].count).to eq(5)
    end
  end

  context 'when the query and user are specified but the user does not have any tweets' do
    let(:variables) { { userId: user1.id, first: 5, query: 'tweet' } }

    it 'returns all tweets that match the query' do
      post('/graphql', params: { query:, variables: variables.to_json })
      result = JSON.parse(response.body, symbolize_names: true)

      expect(result[:data][:tweetIndex][:errors]).to be_nil
      expect(result[:data][:tweetIndex][:success]).to be_truthy
      expect(result[:data][:tweetIndex][:tweets][:nodes].count).to eq(0)
    end
  end
end
