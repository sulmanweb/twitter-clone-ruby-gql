# == Schema Information
#
# Table name: retweets
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  tweet_id   :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_retweets_on_tweet_id              (tweet_id)
#  index_retweets_on_user_id               (user_id)
#  index_retweets_on_user_id_and_tweet_id  (user_id,tweet_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (tweet_id => tweets.id)
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Retweet, type: :model do
  describe 'Validations' do
    context 'when user_id is not present' do
      it 'is invalid' do
        expect(build(:retweet, user_id: nil)).to be_invalid
      end
    end

    context 'when tweet_id is not present' do
      it 'is invalid' do
        expect(build(:retweet, tweet_id: nil)).to be_invalid
      end
    end

    context 'when user_id and tweet_id are not unique' do
      it 'is invalid' do
        retweet = create(:retweet)
        expect(build(:retweet, user_id: retweet.user_id, tweet_id: retweet.tweet_id)).to be_invalid
      end
    end
  end
end
