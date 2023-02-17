require 'rails_helper'

RSpec.describe Mutations::SignIn, type: :request do
  let(:user) { create(:user) }
  let(:query) do
    <<~GQL
      mutation SignIn($input: SignInInput!) {
        signIn(input: $input) {
          errors
          authToken
          user {
            id
          }
        }
      }
    GQL
  end
  let(:variables) do
    {
      input: {
        password: user.password,
        username: user.username
      }
    }
  end

  context 'when the user is valid' do
    it 'returns the user' do
      post '/graphql', params: { query:, variables: variables.to_json }
      result = JSON.parse(response.body, symbolize_names: true)
      expect(result[:data][:signIn][:user][:id]).to eq(user.id.to_s)
    end

    it 'returns the auth token' do
      post '/graphql', params: { query:, variables: variables.to_json }
      result = JSON.parse(response.body, symbolize_names: true)
      expect(result[:data][:signIn][:authToken]).to be_present
    end

    it 'returns no errors' do
      post '/graphql', params: { query:, variables: variables.to_json }
      result = JSON.parse(response.body, symbolize_names: true)
      expect(result[:data][:signIn][:errors]).to be_nil
    end
  end

  context 'when the user is invalid' do
    before { user.username = '' }

    it 'returns no user' do
      post '/graphql', params: { query:, variables: variables.to_json }
      result = JSON.parse(response.body, symbolize_names: true)
      expect(result[:data][:signIn][:user]).to be_nil
    end

    it 'returns no auth token' do
      post '/graphql', params: { query:, variables: variables.to_json }
      result = JSON.parse(response.body, symbolize_names: true)
      expect(result[:data][:signIn][:authToken]).to be_nil
    end

    it 'returns errors' do
      post '/graphql', params: { query:, variables: variables.to_json }
      result = JSON.parse(response.body, symbolize_names: true)
      expect(result[:data][:signIn][:errors]).to be_present
    end
  end
end
