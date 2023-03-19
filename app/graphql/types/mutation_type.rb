module Types
  # @note: This is the type that will be used to represent a mutation.
  class MutationType < Types::BaseObject
    description 'The mutation root of this schema'

    field :sign_in, mutation: Mutations::SignIn, description: 'Sign in a user'
    field :sign_out, mutation: Mutations::SignOut, description: 'Sign out a user'
    field :sign_up, mutation: Mutations::SignUp, description: 'Sign up a new user'

    field :create_tweet, mutation: Mutations::CreateTweet, description: 'Create a new tweet'
    field :delete_tweet, mutation: Mutations::DeleteTweet, description: 'Delete a tweet'
    field :like_tweet, mutation: Mutations::LikeTweet, description: 'Like a tweet'
    field :like_unlike_tweet, mutation: Mutations::LikeUnlikeTweet, description: 'Like or unlike a tweet'
    field :unlike_tweet, mutation: Mutations::UnlikeTweet, description: 'Unlike a tweet'

    field :follow_user, mutation: Mutations::FollowUser, description: 'Follow a user'
    field :un_follow_user, mutation: Mutations::UnFollowUser, description: 'Unfollow a user'

    field :create_retweet, mutation: Mutations::CreateRetweet, description: 'Create a new retweet'
    field :remove_retweet, mutation: Mutations::RemoveRetweet, description: 'Remove a retweet'
  end
end
