# @note: Avoiding introspection query from logs
GraphQL::RailsLogger.configure do |config|
  config.skip_introspection_query = true
end
