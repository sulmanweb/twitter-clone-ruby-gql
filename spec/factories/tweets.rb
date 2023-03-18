# == Schema Information
#
# Table name: tweets
#
#  id                :bigint           not null, primary key
#  is_retweet        :boolean          default(FALSE)
#  text              :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  reply_to_tweet_id :bigint
#  user_id           :bigint           not null
#
# Indexes
#
#  index_tweets_on_reply_to_tweet_id  (reply_to_tweet_id)
#  index_tweets_on_user_id            (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :tweet do
    user
    text { Faker::Lorem.sentence(word_count: 7) }
    is_retweet { false }

    trait :retweet do
      is_retweet { true }
    end

    trait :empty_reply do
      before(:create) do |tweet|
        reply_to_tweet_id { tweet.id }
        text { nil }
      end
    end

    trait :reply do
      before(:create) do |tweet|
        reply_to_tweet_id { tweet.id }
      end
    end

    trait :with_attachment do
      after(:create) do |tweet|
        FactoryBot.create(:attachment, :with_file, tweet_id: tweet.id)
      end
    end
  end
end
