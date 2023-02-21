require 'rails_helper'

RSpec.describe Queries::Me, type: :request do
  let(:query) do
    <<~GQL
      query {
        me {
          errors
          success
          user {
            id
            email
            username
            tweets (first: 5) {
              nodes {
                id
              }
            }
            followersCount
            followingsCount
          }
        }
      }
    GQL
  end

  let(:user) { create(:user) }
  let(:user1) { create(:user) }
  let(:user2) { create(:user) }

  before do
    create_list(:tweet, 10, user:)
    user.active_relationships.create!(followed_id: user1.id)
    user2.active_relationships.create!(followed_id: user.id)
  end

  context 'when the user is logged in' do
    let(:headers) { sign_in_test_headers(user.sessions.create!) }

    it 'returns the current user' do
      post('/graphql', params: { query: }, headers:)
      result = JSON.parse(response.body, symbolize_names: true)

      expect(result[:data][:me][:errors]).to be_empty
      expect(result[:data][:me][:success]).to be_truthy
      expect(result[:data][:me][:user][:id]).to eq(user.id.to_s)
      expect(result[:data][:me][:user][:email]).to eq(user.email)
      expect(result[:data][:me][:user][:username]).to eq(user.username)
      expect(result[:data][:me][:user][:tweets][:nodes].count).to eq(5)
      expect(result[:data][:me][:user][:followersCount]).to eq(1)
      expect(result[:data][:me][:user][:followingsCount]).to eq(1)
    end
  end

  context 'when the user is not logged in' do
    it 'returns an error' do
      post('/graphql', params: { query: })
      result = JSON.parse(response.body, symbolize_names: true)

      expect(result[:data][:me][:errors]).to eq(['You are not logged in.'])
      expect(result[:data][:me][:success]).to be_falsey
      expect(result[:data][:me][:user]).to be_nil
    end
  end
end
