# == Schema Information
#
# Table name: trends
#
#  id          :bigint           not null, primary key
#  name        :string
#  tweet_count :bigint
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_trends_on_name         (name)
#  index_trends_on_tweet_count  (tweet_count)
#
class Trend < ApplicationRecord
  validates :name, presence: true
  validates :tweet_count, presence: true
end
