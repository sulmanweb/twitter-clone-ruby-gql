require 'rails_helper'

RSpec.describe Mutations::SignOut, type: :request do
  let(:user) { create(:user) }
  let(:query) do
    <<~GQL
      mutation SignOut($input: SignOutInput!) {
        signOut(input: $input) {
          errors
          success
        }
      }
    GQL
  end
  let(:variables) do
    {
      input: {}
    }
  end
  let(:session) { create(:session, user:) }
  let(:headers) { sign_in_test_headers(session) }

  context 'when the session is valid' do
    it 'returns no errors and success' do
      post '/graphql', headers:, params: { query:, variables: variables.to_json }
      result = JSON.parse(response.body, symbolize_names: true)
      expect(result[:data][:signOut][:errors]).to be_nil
      expect(result[:data][:signOut][:success]).to be(true)
    end
  end

  context 'when the session is invalid' do
    before { session.token = '' }

    it 'returns errors and no success' do
      post '/graphql', headers:, params: { query:, variables: variables.to_json }
      result = JSON.parse(response.body, symbolize_names: true)
      expect(result[:data][:signOut][:errors]).to be_a(Array)
      expect(result[:data][:signOut][:success]).to be(false)
    end
  end
end
