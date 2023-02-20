require 'rails_helper'

RSpec.describe Users::UnFollowService do
  let(:user) { create(:user) }
  let(:followed_user) { create(:user) }
  let(:follow) { create(:follow, follower_id: user.id, followed_id: followed_user.id) }

  context 'when user is not logged in' do
    it 'returns error' do
      result = described_class.call(nil, followed_user.id)
      expect(result.success).to be_falsey
      expect(result.errors).to be_present
    end
  end

  context 'when followed user does not exist' do
    it 'returns error' do
      result = described_class.call(user, 0)
      expect(result.success).to be_falsey
      expect(result.errors).to be_present
    end
  end

  context 'when follow does not exist' do
    it 'returns error' do
      result = described_class.call(user, followed_user.id)
      expect(result.success).to be_falsey
      expect(result.errors).to be_present
    end
  end

  context 'when user is logged in and followed user exists' do
    it 'returns success' do
      follow
      result = described_class.call(user, followed_user.id)
      expect(result.success).to be_truthy
      expect(result.errors).to be_nil
    end
  end
end
