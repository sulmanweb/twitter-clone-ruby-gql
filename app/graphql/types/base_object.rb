module Types
  # @note: This file was generated automatically by `rails generate graphql:install`
  class BaseObject < GraphQL::Schema::Object
    description 'The base object for all objects'
    edge_type_class(Types::BaseEdge)
    connection_type_class(Types::BaseConnection)
    field_class Types::BaseField
  end
end
