class AddRatingToPlayer < ActiveRecord::Migration
  def change
    add_column :players, :rating, :integer, default: 1700
    add_column :players, :development_coefficient, :integer, default: 40
  end
end
