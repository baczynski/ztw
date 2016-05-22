class AddRatingChangeToMatch < ActiveRecord::Migration
  def change
    add_column :matches, :white_rating_change, :integer
    add_column :matches, :black_rating_change, :integer
  end
end
