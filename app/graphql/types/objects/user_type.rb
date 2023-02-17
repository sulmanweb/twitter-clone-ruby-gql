module Types
  module Objects
    # @note: This is the type that will be used to represent a user.
    class UserType < Types::BaseObject
      description 'A user'

      field :bio, String, null: true, description: 'The bio of the user'
      field :email, String, null: false, description: 'The email of the user'
      field :id, ID, null: false, description: 'The id of the user'
      field :location, String, null: true, description: 'The location of the user'
      field :name, String, null: false, description: 'The name of the user'
      field :username, String, null: false, description: 'The username of the user'
      field :website, String, null: true, description: 'The website of the user'
      # @todo: Add the profile picture field.
    end
  end
end
