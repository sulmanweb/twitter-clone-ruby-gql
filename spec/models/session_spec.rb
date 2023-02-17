# == Schema Information
#
# Table name: sessions
#
#  id           :bigint           not null, primary key
#  active       :boolean          default(TRUE)
#  last_used_at :datetime
#  token        :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :bigint           not null
#
# Indexes
#
#  index_sessions_on_active   (active)
#  index_sessions_on_token    (token) UNIQUE
#  index_sessions_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Session, type: :model do
  it 'has a valid factory' do
    expect(build(:session)).to be_valid
  end

  describe 'ActiveRecord associations' do
    it { is_expected.to belong_to(:user) }
  end

  describe '.used!' do
    let(:session) { create(:session) }

    it 'updates the last_used_at' do
      expect { session.used! }.to change(session, :last_used_at)
    end
  end

  describe 'Session.find_by_token' do
    let(:session) { create(:session) }

    context 'when the session is not active' do
      before { session.update(active: false) }

      it 'returns nil' do
        expect(described_class.find_by_token(session.token)).to be_nil # rubocop:disable Rails/DynamicFindBy
      end
    end

    context 'when the session is active' do
      it 'returns the session' do
        expect(described_class.find_by_token(session.token)).to eq(session) # rubocop:disable Rails/DynamicFindBy
      end
    end

    context 'when the session does not exist' do
      it 'returns nil' do
        expect(described_class.find_by_token('invalid')).to be_nil # rubocop:disable Rails/DynamicFindBy
      end
    end
  end

  describe '.generate_token' do
    let(:session) { build(:session) }

    it 'generates a token' do
      expect { session.save }.to change(session, :token)
    end
  end

  describe '.inactive!' do
    let(:session) { create(:session) }

    it 'updates the active flag to inactive' do
      expect { session.inactive! }.to change(session, :active).from(true).to(false)
    end
  end

  describe '.active' do
    let!(:session) { create(:session, active: false) }

    it 'updates the active flag to active' do
      expect { session.active! }.to change(session, :active).from(false).to(true)
    end
  end
end
