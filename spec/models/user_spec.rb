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
end
