module Types
  # @note: This is the type that will be used to represent a mutation.
  class MutationType < Types::BaseObject
    description 'The mutation root of this schema'

    field :sign_up, mutation: Mutations::SignUp, description: 'Sign up a new user'
  end
end
