module Tweets
  # @note: This service is used to create a new tweet.
  # @param text [String] The text of the tweet.
  # @param user [User] The user who is creating the tweet.
  # @return [Struct] A struct with the following attributes:
  #  - success [Boolean] A boolean indicating if the tweet was created successfully.
  #  - errors [Array] An array of errors.
  #  - tweet [Tweet] The tweet created.
  # @example
  #  Tweets::CreateService.new(text: 'Hello world!', user: current_user).call
  class CreateService
    attr_reader :text, :user, :result

    def initialize(text:, user:)
      @text = text
      @user = user
      @result = Struct.new(:success, :errors, :tweet)
    end

    def call
      return result.new(false, ['You need to be logged in to perform this action.'], nil) if user.blank?

      tweet = Tweet.new(text:, user:)

      if tweet.save
        result.new(true, nil, tweet)
        # @todo: Send a notification to the user followers.
      else
        result.new(false, tweet.errors.full_messages, nil)
      end
    end

    # @note: This is the method that will be called to execute the service.
    class << self
      def call(text:, user:)
        new(text:, user:).call
      end
    end
  end
end
