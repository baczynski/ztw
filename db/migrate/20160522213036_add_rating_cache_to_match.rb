class AddRatingCacheToMatch < ActiveRecord::Migration
  def change
    add_column :matches, :white_rating_before, :integer
    add_column :matches, :black_rating_before, :integer
  end
end
