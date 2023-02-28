module Mutations
  # @note: This is the mutation that will be used to sign in a user.
  class SignIn < Mutations::BaseMutation
    description 'Sign in a user'

    argument :password, String, required: true, description: 'The password of the user'
    argument :username, String, required: true, description: 'The username of the user'

    field :auth_token, String, null: true, description: 'The auth token of the user'
    field :errors, [String], null: true, description: 'The errors of the mutation'
    field :user, Types::Objects::UserType, null: true, description: 'The user'

    def resolve(username:, password:)
      Users::SigninService.call(username:, password:)
    end
  end
end
