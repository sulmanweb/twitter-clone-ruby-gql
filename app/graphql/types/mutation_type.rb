module Types
  # @note: This is the type that will be used to represent a mutation.
  class MutationType < Types::BaseObject
    description 'The mutation root of this schema'

    field :sign_in, mutation: Mutations::SignIn, description: 'Sign in a user'
    field :sign_up, mutation: Mutations::SignUp, description: 'Sign up a new user'
  end
end
