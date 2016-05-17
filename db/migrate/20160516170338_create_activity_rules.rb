class CreateActivityRules < ActiveRecord::Migration
  def change
    create_table :activity_rules do |t|
      t.integer :games_limit

      t.timestamps null: false
    end
  end
end
