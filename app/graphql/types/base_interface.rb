module Types
  # @note: This file was generated automatically by `rails generate graphql:install`
  module BaseInterface # rubocop:disable GraphQL/ObjectDescription
    include GraphQL::Schema::Interface
    edge_type_class(Types::BaseEdge)
    connection_type_class(Types::BaseConnection)

    field_class Types::BaseField
  end
end
