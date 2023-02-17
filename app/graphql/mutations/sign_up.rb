module Mutations
  # @note: This is the mutation that will be used to sign up a new user.
  class SignUp < Mutations::BaseMutation
    description 'Sign up a new user'

    argument :email, String, required: true, description: 'The email of the user'
    argument :name, String, required: true, description: 'The name of the user'
    argument :password, String, required: true, description: 'The password of the user'
    argument :username, String, required: true, description: 'The username of the user'

    field :auth_token, String, null: true, description: 'The auth token of the user'
    field :errors, [String], null: true, description: 'The errors of the mutation'
    field :user, Types::Objects::UserType, null: true, description: 'The user'

    def resolve(username:, password:, email:, name:)
      result = Users::SignupService.call(username:, password:, email:, name:)
      {
        auth_token: result.auth_token,
        errors: result.errors,
        user: result.user
      }
    end
  end
end
