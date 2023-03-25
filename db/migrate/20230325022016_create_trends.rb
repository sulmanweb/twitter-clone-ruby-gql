# @note: This migration is for the trends table
class CreateTrends < ActiveRecord::Migration[7.0]
  def change
    create_table :trends do |t|
      t.string :name
      t.bigint :tweet_count

      t.timestamps
    end
    add_index :trends, :name
    add_index :trends, :tweet_count
  end
end
