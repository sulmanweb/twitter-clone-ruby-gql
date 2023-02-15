module Types
  # @note: This file was generated automatically by `rails generate graphql:install`
  class BaseInputObject < GraphQL::Schema::InputObject
    description 'The base input object for all input objects'
    argument_class Types::BaseArgument
  end
end
