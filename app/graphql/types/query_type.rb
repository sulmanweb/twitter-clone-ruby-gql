module Types
  # @note: This is the root query type.
  class QueryType < Types::BaseObject
    description 'The root query'
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    field :me, resolver: Queries::Me, description: 'Get the current user'
  end
end
