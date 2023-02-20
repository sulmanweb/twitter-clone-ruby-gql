require 'rails_helper'

RSpec.describe Users::FollowService do
  let(:user) { create(:user) }
  let(:followed_user) { create(:user) }

  describe '#call' do
    context 'when the user is not logged in' do
      let(:user) { nil }

      it 'returns an error' do
        resp = described_class.call(user:, followed_user:)
        expect(resp.success).to be_falsey
        expect(resp.errors).to eq(['You need to be logged in to perform this action.'])
      end
    end

    context 'when the user is logged in' do
      context 'when the user is already following the other user' do
        before do
          user.follow(followed_user)
        end

        it 'returns an error' do
          resp = described_class.call(user:, followed_user:)
          expect(resp.success).to be_falsey
          expect(resp.errors).to eq(['Follower has already been taken'])
        end
      end

      context 'when the user is not already following the other user' do
        it 'returns success' do
          resp = described_class.call(user:, followed_user:)
          expect(resp.success).to be_truthy
          expect(resp.errors).to be_nil
        end
      end
    end
  end
end
