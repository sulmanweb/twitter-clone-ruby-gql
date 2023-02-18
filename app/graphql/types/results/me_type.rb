module Types
  module Results
    # @note: This is the query for the current user.
    class MeType < Types::BaseObject
      description 'Get the current user'

      field :errors, [String], null: false, description: 'The errors that occurred'
      field :success, Boolean, null: false, description: 'Whether the query was successful'
      field :user, Types::Objects::UserType, null: true, description: 'The current user'
    end
  end
end
