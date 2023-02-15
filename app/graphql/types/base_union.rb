module Types
  # @note: This file was generated automatically by `rails generate graphql:install`
  class BaseUnion < GraphQL::Schema::Union
    description 'The base union for all unions'
    edge_type_class(Types::BaseEdge)
    connection_type_class(Types::BaseConnection)
  end
end
