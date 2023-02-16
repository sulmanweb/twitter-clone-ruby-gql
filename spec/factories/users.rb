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
FactoryBot.define do
  factory :user do
    username { Faker::Internet.unique.username(specifier: 4..20, separators: %w[_ .]) }
    email { Faker::Internet.unique.email }
    password { 'Abcd@1234' }
    name { Faker::Name.name }
    bio { Faker::Lorem.paragraph(sentence_count: 2) }
    location { Faker::Address.city }
    website { Faker::Internet.url }
  end
end
