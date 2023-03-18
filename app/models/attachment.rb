# == Schema Information
#
# Table name: attachments
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  tweet_id   :bigint           not null
#
# Indexes
#
#  index_attachments_on_tweet_id  (tweet_id)
#
# Foreign Keys
#
#  fk_rails_...  (tweet_id => tweets.id)
#
class Attachment < ApplicationRecord
  # @note: Active Storage macro
  has_one_attached :file

  # @note: Associations
  belongs_to :tweet
end
