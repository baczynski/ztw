class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.integer :white_player_id
      t.integer :black_player_id
      t.integer :round
      t.string :result
      t.integer :tournament_id

      t.timestamps null: false
    end
  end
end
