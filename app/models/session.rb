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
class Session < ApplicationRecord
  # @note: Relations
  belongs_to :user

  # @note: Constants
  TOKEN_LENGTH = 64

  # @note: Validations
  validates :token, presence: true, uniqueness: true

  # @note: Scopes
  # @note: This scope is used to find active sessions
  scope :active, -> { where(active: true) }

  # @note: Callbacks
  before_validation :generate_token, on: :create
  after_create :used!

  # @note: This method is used to mark a session as used
  # @return [Session]
  def used!
    update(last_used_at: Time.zone.now)
  end

  # @note: This method is used to find the active session by token
  # @param token [String]
  # @return [Session]
  def self.find_by_token(token)
    Session.active.find_by(token:)
  end

  # @note: This method is used to mark a session as inactive
  # @return [Session]
  def inactive!
    update(active: false)
  end

  # @note: This method is used to mark a session as active
  # @return [Session]
  def active!
    update(active: true)
  end

  private

  # @note: This method is used to generate a unique token
  # @return [String]
  def generate_token
    loop do
      self.token = SecureRandom.hex(TOKEN_LENGTH)
      break unless Session.exists?(token:)
    end
  end
end
