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
FactoryBot.define do
  factory :attachment do
    tweet

    trait :with_file do
      after(:create) do |attachment|
        attachment.file.attach(io: Rails.root.join('spec/support/assets/images/avatar.png').open, filename: 'avatar.png', content_type: 'image/png')
      end
    end
  end
end
