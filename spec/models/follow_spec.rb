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
require 'rails_helper'

RSpec.describe Follow, type: :model do
  it 'has a valid factory' do
    expect(build(:follow)).to be_valid
  end

  describe 'validations' do
    it 'is invalid without a follower' do
      expect(build(:follow, follower: nil)).not_to be_valid
    end

    it 'is invalid without a followed' do
      expect(build(:follow, followed: nil)).not_to be_valid
    end

    it 'is invalid if the follower is the same as the followed' do
      user = create(:user)
      expect(build(:follow, follower: user, followed: user)).not_to be_valid
    end

    it 'is invalid if the follower is already following the followed' do
      user1 = create(:user)
      user2 = create(:user)
      user1.follow(user2)
      expect(build(:follow, follower: user1, followed: user2)).not_to be_valid
    end
  end

  describe 'associations' do
    it 'belongs to a follower' do
      expect(build(:follow)).to respond_to(:follower)
    end

    it 'belongs to a followed' do
      expect(build(:follow)).to respond_to(:followed)
    end
  end
end
