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

  # @note: Relations
  has_many :sessions, dependent: :destroy
  has_many :tweets, dependent: :destroy

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

  private

  # @note: This method is used to validate the password only when it is present or when the user is being created.
  # @return [Boolean]
  def password_required?
    new_record? || password.present?
  end
end
