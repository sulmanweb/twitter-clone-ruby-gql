require 'rails_helper'

RSpec.describe Queries::TweetIndex, type: :request do
  let(:query) do
    <<~GQL
      query($userId: ID, $first: Int) {
        tweetIndex(userId: $userId) {
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
  let(:variables) { { userId: user_id, first: } }

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
end
