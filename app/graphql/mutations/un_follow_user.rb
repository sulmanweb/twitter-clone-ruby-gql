module Mutations
  # @note: This class is used to unfollow a user.
  class UnFollowUser < BaseMutation
    description 'Unfollow a user.'

    argument :followed_user_id, ID, required: true, description: 'ID of the user to be unfollowed.'

    field :errors, [String], null: true, description: 'Returns error if the user is not unfollowed.'
    field :success, Boolean, null: true, description: 'Returns true if the user is unfollowed.'

    def resolve(followed_user_id:)
      Users::UnFollowService.call(context[:current_user], followed_user_id)
    end
  end
end
