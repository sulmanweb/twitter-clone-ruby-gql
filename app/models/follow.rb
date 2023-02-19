# == Schema Information
#
# Table name: follows
#
#  id          :bigint           not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  followed_id :bigint
#  follower_id :bigint
#
# Indexes
#
#  index_follows_on_followed_id                  (followed_id)
#  index_follows_on_follower_id                  (follower_id)
#  index_follows_on_follower_id_and_followed_id  (follower_id,followed_id) UNIQUE
#
class Follow < ApplicationRecord
  # @note: Associations
  belongs_to :follower, class_name: 'User'
  belongs_to :followed, class_name: 'User'

  # @note: Validations
  validates :follower_id, uniqueness: { scope: :followed_id }
  validate :follower_is_not_followed

  def follower_is_not_followed
    errors.add(:follower, 'cannot follow themselves') if follower == followed
  end
end
