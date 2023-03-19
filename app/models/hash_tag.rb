# == Schema Information
#
# Table name: hash_tags
#
#  id         :bigint           not null, primary key
#  tag        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  tweet_id   :bigint           not null
#
# Indexes
#
#  index_hash_tags_on_tweet_id          (tweet_id)
#  index_hash_tags_on_tweet_id_and_tag  (tweet_id,tag) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (tweet_id => tweets.id)
#
class HashTag < ApplicationRecord
  belongs_to :tweet

  validates :tag, presence: true
  validates :tag, uniqueness: { scope: :tweet_id }
end
