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
require 'rails_helper'

RSpec.describe Attachment, type: :model do
  let(:attachment) { create(:attachment) }

  describe 'file' do
    it 'returns an image if it exists' do
      attachment.file.attach(io: Rails.root.join('spec/support/assets/images/avatar.png').open, filename: 'avatar.png', content_type: 'image/png')
      expect(attachment.file).to be_attached
    end

    it 'returns nothing if it does not exist' do
      expect(attachment.file).not_to be_attached
    end
  end
end
