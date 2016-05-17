class CreateRatingRules < ActiveRecord::Migration
  def change
    create_table :rating_rules do |t|
      t.integer :min_rating

      t.timestamps null: false
    end
  end
end
