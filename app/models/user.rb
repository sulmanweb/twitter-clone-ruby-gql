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
class User < ApplicationRecord
  # @note: Entities
  has_secure_password
  has_one_attached :profile_picture
  include PgSearch::Model

  # @note: Relations
  has_many :sessions, dependent: :destroy
  has_many :tweets, dependent: :destroy
  has_many :active_relationships, class_name: 'Follow', foreign_key: 'follower_id', dependent: :destroy,
                                  inverse_of: :follower
  has_many :followings, through: :active_relationships, source: :followed
  has_many :passive_relationships, class_name: 'Follow', foreign_key: 'followed_id', dependent: :destroy,
                                   inverse_of: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  # @note: Validations
  validates :username, presence: true, uniqueness: true, length: { minimum: 4, maximum: 20 },
                       format: { with: /\A[a-z0-9_.]+\z/, message: I18n.t('models.user.username_format') }
  validates :email, presence: true, uniqueness: { case_sensitive: false },
                    format: { with: /\A([\w+-].?)+@[a-z\d-]+(\.[a-z]+)*\.[a-z]+\z/i,
                              message: I18n.t('models.user.email_format') }
  validates :password, length: { minimum: 8, maximum: 72 },
                       format: { with: /\A(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}\z/,
                                 message: I18n.t('models.user.password_format') }, if: :password_required?
  validates :name, length: { maximum: 50 }, allow_blank: true
  validates :bio, length: { maximum: 200 }, allow_blank: true
  validates :location, length: { maximum: 60 }, allow_blank: true
  validates :website,
            length: { maximum: 160 },
            format: { with: /\A#{URI::DEFAULT_PARSER.make_regexp(%w[http https])}\z/, message: I18n.t('models.user.website_format') }, allow_blank: true

  # @note: Scopes
  pg_search_scope :search_by_username_or_name, against: %i[username name], using: { tsearch: { prefix: true } }

  # @note: This method is used to check if the user is following another user.
  # @param [User] other_user
  # @return [Boolean]
  def following?(other_user)
    followings.include?(other_user)
  end

  private

  # @note: This method is used to validate the password only when it is present or when the user is being created.
  # @return [Boolean]
  def password_required?
    new_record? || password.present?
  end
end
