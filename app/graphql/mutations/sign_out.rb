module Mutations
  # @note: This is the mutation that will be used to sign out a user.
  class SignOut < Mutations::BaseMutation
    description 'Sign out a user'

    field :errors, [String], null: true, description: 'The errors of the mutation'
    field :success, Boolean, null: true, description: 'The success of the mutation'

    def resolve
      Users::SignoutService.call(session: context[:current_session])
    end
  end
end
