# @note: This migration comes from
# `rails g model User username:string:uniq email:string:uniq password_digest:string name:string bio:string
# location:string website:string`
class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :password_digest
      t.string :name
      t.string :bio
      t.string :location
      t.string :website

      t.timestamps
    end
    add_index :users, :username, unique: true
    add_index :users, :email, unique: true
  end
end
