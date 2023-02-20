module Mutations
  # @note: This is the mutation that will be used to follow a user.
  class FollowUser < Mutations::BaseMutation
    description 'Follow a user'

    argument :user_id, ID, required: true, description: 'The ID of the user'

    field :errors, [String], null: true, description: 'The errors of the mutation'
    field :success, Boolean, null: true, description: 'The success of the mutation'

    def resolve(user_id:)
      Users::FollowService.call(user: context[:current_user], followed_user: User.find_by(id: user_id))
    end
  end
end
