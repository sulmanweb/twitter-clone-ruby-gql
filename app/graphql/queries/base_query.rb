module Queries
  # @note: This is the base query class for all queries.
  class BaseQuery < GraphQL::Schema::Resolver
    description 'The base query'

    def current_user
      context[:current_user]
    end

    def authenticate_user
      if current_user
        { errors: [], success: true }
      else
        { errors: ['You are not logged in.'], success: false }
      end
    end
  end
end
