class AddRules < ActiveRecord::Migration
  def change
    add_reference :tournaments, :rule, polymorphic: true, index: true
  end
end
