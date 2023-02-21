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

      field :tweets, Types::Objects::TweetType.connection_type, null: true, description: 'The tweets of the user'

      field :followers, Types::Objects::UserType.connection_type, null: true, description: 'The followers of the user'
      field :followers_count, Integer, null: false, description: 'The number of followers of the user'
      field :followings, Types::Objects::UserType.connection_type, null: true, description: 'The followings of the user'
      field :followings_count, Integer, null: false, description: 'The number of followings of the user'

      def tweets
        object.tweets.order(id: :desc)
      end

      def followers
        object.followers.order(id: :desc)
      end

      def followers_count
        object.followers.count
      end

      def followings
        object.followings.order(id: :desc)
      end

      def followings_count
        object.followings.count
      end
    end
  end
end
