# == Schema Information
#
# Table name: blocklists
#
#  id              :bigint           not null, primary key
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  blocked_user_id :bigint
#  user_id         :bigint           not null
#
# Indexes
#
#  index_blocklists_on_blocked_user_id              (blocked_user_id)
#  index_blocklists_on_user_id                      (user_id)
#  index_blocklists_on_user_id_and_blocked_user_id  (user_id,blocked_user_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Blocklist, type: :model do
  it 'has a valid factory' do
    expect(build(:blocklist)).to be_valid
  end

  it 'is invalid without a user' do
    expect(build(:blocklist, user: nil)).not_to be_valid
  end

  it 'is invalid without a blocked_user' do
    expect(build(:blocklist, blocked_user: nil)).not_to be_valid
  end

  it 'is invalid with a duplicate user_id and blocked_user_id' do
    blocklist = create(:blocklist)
    expect(build(:blocklist, user: blocklist.user, blocked_user: blocklist.blocked_user)).not_to be_valid
    expect(build(:blocklist, blocked_user: blocklist.user, user: blocklist.blocked_user)).to be_valid
  end
end
