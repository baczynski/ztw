class CreateTournaments < ActiveRecord::Migration
  def change
    create_table :tournaments do |t|
      t.string :name
      t.text :description
      t.datetime :start_date
      t.string :tournament_type
      t.integer :rounds

      t.timestamps null: false
    end
  end
end
