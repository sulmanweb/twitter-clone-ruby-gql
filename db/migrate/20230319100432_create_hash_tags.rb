# @note: This migration is for the hash_tags table
class CreateHashTags < ActiveRecord::Migration[7.0]
  def change
    create_table :hash_tags do |t|
      t.references :tweet, null: false, foreign_key: true
      t.string :tag

      t.timestamps
    end
    add_index :hash_tags, %i[tweet_id tag], unique: true
  end
end
