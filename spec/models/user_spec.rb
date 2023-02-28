# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  bio             :string
#  email           :string
#  location        :string
#  name            :string
#  password_digest :string
#  username        :string
#  website         :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_email     (email) UNIQUE
#  index_users_on_username  (username) UNIQUE
#
require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { build(:user) }

  it 'has a valid factory' do
    expect(user).to be_valid
  end

  describe 'ActiveRecord associations' do
    it { is_expected.to have_many(:sessions).dependent(:destroy) }
  end

  describe 'ActiveModel validations' do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:username) }
    it { is_expected.to validate_presence_of(:password) }
    it { is_expected.to validate_length_of(:username).is_at_least(4).is_at_most(20) }
    it { is_expected.to validate_length_of(:password).is_at_least(8).is_at_most(72) }
    it { is_expected.to validate_length_of(:name).is_at_most(50) }
    it { is_expected.to validate_length_of(:bio).is_at_most(200) }
    it { is_expected.to validate_length_of(:location).is_at_most(60) }
    it { is_expected.to validate_length_of(:website).is_at_most(160) }
    it { is_expected.to validate_uniqueness_of(:username) }
    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
    it { is_expected.to allow_value('Abcd@1234').for(:password) }
    it { is_expected.not_to allow_value('abcd').for(:password) }
    it { is_expected.not_to allow_value('abcd@1234').for(:password) }
    it { is_expected.not_to allow_value('Abcd1234').for(:password) }
    it { is_expected.to allow_value('sulman@hey.com').for(:email) }
    it { is_expected.not_to allow_value('sulman@hey').for(:email) }
    it { is_expected.not_to allow_value('sulman@hey.').for(:email) }
    it { is_expected.not_to allow_value('sulman-hey').for(:username) }
    it { is_expected.not_to allow_value('sulman hey').for(:username) }
    it { is_expected.to allow_value('sulman_hey').for(:username) }
    it { is_expected.to allow_value('sulman.hey').for(:username) }
    it { is_expected.to allow_value('http://sulman.com').for(:website) }
    it { is_expected.to allow_value('https://sulman.com').for(:website) }
    it { is_expected.not_to allow_value('sulman.com').for(:website) }
    it { is_expected.not_to allow_value('sulman').for(:website) }
  end

  describe 'profile_picture' do
    it 'returns an image if it exists' do
      user.profile_picture.attach(io: File.open(Rails.root.join('spec/support/assets/images/avatar.png')), filename: 'avatar.png', content_type: 'image/png') # rubocop:disable Rails/RootPathnameMethods
      expect(user.profile_picture).to be_attached
    end

    it 'returns nothing if it does not exist' do
      expect(user.profile_picture).not_to be_attached
    end
  end

  describe 'following?' do
    it 'returns true if the user is following another user' do
      user = create(:user)
      user2 = create(:user)
      create(:follow, follower: user, followed: user2)
      expect(user.following?(user2)).to be_truthy # rubocop:disable RSpec/PredicateMatcher
    end
  end

  describe 'follow' do
    it 'creates a new follow relationship' do
      user = create(:user)
      user2 = create(:user)
      create(:follow, follower: user, followed: user2)
      expect(user.following?(user2)).to be_truthy # rubocop:disable RSpec/PredicateMatcher
    end
  end

  describe 'Follow system' do
    it 'follows and unfollow a user' do
      user1 = create(:user)
      user2 = create(:user)
      create(:follow, follower: user1, followed: user2)
      expect(user1.followings).to include(user2)
      expect(user2.followers).to include(user1)
      expect(user2.followings).not_to include(user1)
      expect(user1.followers).not_to include(user2)
    end
  end

  describe 'search_by_username_or_name' do
    context 'when the user exists' do
      it 'returns the user' do
        user = create(:user)
        expect(described_class.search_by_username_or_name(user.username)).to eq([user])
      end
    end

    context 'when the user does not exist' do
      it 'returns an empty array' do
        expect(described_class.search_by_username_or_name('sulman')).to eq([])
      end
    end

    context 'when user exists in followings' do
      it 'returns the user' do
        user = create(:user)
        user2 = create(:user)
        create(:follow, follower: user, followed: user2)
        expect(user.followings.search_by_username_or_name(user2.username)).to eq([user2])
        expect(user.followers.search_by_username_or_name(user2.username)).to eq([])
      end
    end

    context 'when user exists in followers' do
      it 'returns the user' do
        user = create(:user)
        user2 = create(:user)
        create(:follow, follower: user2, followed: user)
        expect(user.followings.search_by_username_or_name(user2.username)).to eq([])
        expect(user.followers.search_by_username_or_name(user2.username)).to eq([user2])
      end
    end
  end
end
