require 'rails_helper'

RSpec.describe Mutations::UnFollowUser, type: :request do
  let(:user) { create(:user) }
  let(:followed_user) { create(:user) }

  describe '#resolve' do
    context 'when the user is not logged in' do
      let(:user) { nil }

      it 'returns an error' do
        post '/graphql', params: { query: query(followed_user_id: followed_user.id) }
        json = JSON.parse(response.body)
        data = json['data']['unFollowUser']
        expect(data['success']).to be_falsey
        expect(data['errors']).to be_present
      end
    end

    context 'when the user is logged in' do
      context 'when the user is not following the other user' do
        it 'returns an error' do
          post '/graphql', params: { query: query(followed_user_id: followed_user.id) }, headers: sign_in_test_headers(user.sessions.create!)
          json = JSON.parse(response.body)
          data = json['data']['unFollowUser']
          expect(data['success']).to be_falsey
          expect(data['errors']).to be_present
        end
      end

      context 'when the user is following the other user' do
        before do
          user.follow(followed_user)
        end

        it 'returns success' do
          post '/graphql', params: { query: query(followed_user_id: followed_user.id) }, headers: sign_in_test_headers(user.sessions.create!)
          json = JSON.parse(response.body)
          data = json['data']['unFollowUser']
          expect(data['success']).to be_truthy
          expect(data['errors']).to be_nil
        end
      end

      context 'when the user is trying to unfollow themselves' do
        it 'returns an error' do
          post '/graphql', params: { query: query(followed_user_id: user.id) }, headers: sign_in_test_headers(user.sessions.create!)
          json = JSON.parse(response.body)
          data = json['data']['unFollowUser']
          expect(data['success']).to be_falsey
          expect(data['errors']).to be_present
        end
      end

      context 'when the user is trying to unfollow a user that does not exist' do
        it 'returns an error' do
          post '/graphql', params: { query: query(followed_user_id: 0) }, headers: sign_in_test_headers(user.sessions.create!)
          json = JSON.parse(response.body)
          data = json['data']['unFollowUser']
          expect(data['success']).to be_falsey
          expect(data['errors']).to be_present
        end
      end
    end
  end

  def query(followed_user_id:)
    <<~GQL
      mutation {
        unFollowUser(input: { followedUserId: #{followed_user_id} }) {
          success
          errors
        }
      }
    GQL
  end
end
