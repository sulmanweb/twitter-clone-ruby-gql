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

      field :tweets, Types::Objects::TweetType.connection_type, null: true, description: 'The tweets of the user' do
        argument :query, String, required: false, description: 'The query to search for tweets'
      end

      field :followers, Types::Objects::UserType.connection_type, null: true, description: 'The followers of the user' do
        argument :query, String, required: false, description: 'The query to search for followers'
      end
      field :followers_count, Integer, null: false, description: 'The number of followers of the user'
      field :followings, Types::Objects::UserType.connection_type, null: true, description: 'The followings of the user' do
        argument :query, String, required: false, description: 'The query to search for followings'
      end
      field :followings_count, Integer, null: false, description: 'The number of followings of the user'

      field :retweet_count, Integer, null: false, description: 'The number of retweets of the user'
      field :retweets, Types::Objects::RetweetType.connection_type, null: true, description: 'The retweets of the user'

      field :likes, Types::Objects::LikeType.connection_type, null: true, description: 'The likes of the user'
      field :likes_count, Integer, null: false, description: 'The number of likes of the user'

      def tweets(query: nil)
        if query.present?
          object.tweets.search_by_text(query)
        else
          object.tweets.order(id: :desc)
        end
      end

      def followers(query: nil)
        if query.present?
          object.followers.search_by_username_or_name(query)
        else
          object.followers.order(id: :desc)
        end
      end

      def followers_count
        object.followers.count
      end

      def followings(query: nil)
        if query.present?
          object.followings.search_by_username_or_name(query)
        else
          object.followings.order(id: :desc)
        end
      end

      def followings_count
        object.followings.count
      end

      def retweet_count
        object.retweets.count
      end

      def retweets
        object.retweets.order(id: :desc)
      end

      def likes_count
        object.likes.count
      end

      def likes
        object.likes.order(id: :desc)
      end
    end
  end
end
