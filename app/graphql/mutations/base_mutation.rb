module Mutations
  # Base mutation class for all mutations
  class BaseMutation < GraphQL::Schema::RelayClassicMutation
    description 'The base mutation for all mutations'
    argument_class Types::BaseArgument
    field_class Types::BaseField
    input_object_class Types::BaseInputObject
    object_class Types::BaseObject
  end
end
