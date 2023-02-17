require 'rails_helper'

RSpec.describe Mutations::SignUp, type: :request do
  let(:user) { build(:user) }
  let(:query) do
    <<~GQL
      mutation SignUp($input: SignUpInput!) {
        signUp(input: $input) {
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
        email: user.email,
        name: user.name,
        password: user.password,
        username: user.username
      }
    }
  end

  context 'when the user is valid' do
    it 'returns the user' do
      post '/graphql', params: { query:, variables: variables.to_json }
      result = JSON.parse(response.body, symbolize_names: true)
      expect(result[:data][:signUp][:user][:id]).to eq(User.last.id.to_s)
    end

    it 'returns the auth token' do
      post '/graphql', params: { query:, variables: variables.to_json }
      result = JSON.parse(response.body, symbolize_names: true)
      expect(result[:data][:signUp][:authToken]).to be_present
    end

    it 'returns no errors' do
      post '/graphql', params: { query:, variables: variables.to_json }
      result = JSON.parse(response.body, symbolize_names: true)
      expect(result[:data][:signUp][:errors]).to be_nil
    end
  end

  context 'when the user is invalid' do
    before { user.username = '' }

    it 'returns no user' do
      post '/graphql', params: { query:, variables: variables.to_json }
      result = JSON.parse(response.body, symbolize_names: true)
      expect(result[:data][:signUp][:user]).to be_nil
    end

    it 'returns no auth token' do
      post '/graphql', params: { query:, variables: variables.to_json }
      result = JSON.parse(response.body, symbolize_names: true)
      expect(result[:data][:signUp][:authToken]).to be_nil
    end

    it 'returns the errors' do
      post '/graphql', params: { query:, variables: variables.to_json }
      result = JSON.parse(response.body, symbolize_names: true)
      expect(result[:data][:signUp][:errors]).to be_present
    end
  end
end
