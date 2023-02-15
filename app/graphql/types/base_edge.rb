module Types
  # @note: This file was generated automatically by `rails generate graphql:install`
  class BaseEdge < Types::BaseObject
    description 'The base edge for all edges'
    # add `node` and `cursor` fields, as well as `node_type(...)` override
    include GraphQL::Types::Relay::EdgeBehaviors
  end
end
