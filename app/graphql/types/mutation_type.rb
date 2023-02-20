module Types
  # @note: This is the type that will be used to represent a mutation.
  class MutationType < Types::BaseObject
    description 'The mutation root of this schema'

    field :sign_in, mutation: Mutations::SignIn, description: 'Sign in a user'
    field :sign_out, mutation: Mutations::SignOut, description: 'Sign out a user'
    field :sign_up, mutation: Mutations::SignUp, description: 'Sign up a new user'

    field :create_tweet, mutation: Mutations::CreateTweet, description: 'Create a new tweet'

    field :follow_user, mutation: Mutations::FollowUser, description: 'Follow a user'
    field :un_follow_user, mutation: Mutations::UnFollowUser, description: 'Unfollow a user'
  end
end
