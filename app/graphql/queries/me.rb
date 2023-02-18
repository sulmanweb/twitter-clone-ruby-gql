module Queries
  # @note: This is the query for the current user.
  class Me < Queries::BaseQuery
    description 'Get the current user'

    type Types::Results::MeType, null: false

    def resolve
      result = authenticate_user
      result[:user] = current_user

      result
    end
  end
end
