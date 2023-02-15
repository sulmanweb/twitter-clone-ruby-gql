module Types
  # @note: This file was generated automatically by `rails generate graphql:install`
  class BaseConnection < Types::BaseObject
    description 'The base connection for all connections'
    # add `nodes` and `pageInfo` fields, as well as `edge_type(...)` and `node_nullable(...)` overrides
    include GraphQL::Types::Relay::ConnectionBehaviors
  end
end
