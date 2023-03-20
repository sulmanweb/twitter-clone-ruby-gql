# @note: This migration is for the blocklist feature.
class CreateBlocklists < ActiveRecord::Migration[7.0]
  def change
    create_table :blocklists do |t|
      t.references :user, null: false, foreign_key: true
      t.bigint :blocked_user_id

      t.timestamps
    end
    add_index :blocklists, :blocked_user_id
    add_index :blocklists, [:user_id, :blocked_user_id], unique: true
  end
end
