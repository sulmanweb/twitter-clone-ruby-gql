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
FactoryBot.define do
  factory :blocklist do
    user
    blocked_user factory: :user
  end
end
