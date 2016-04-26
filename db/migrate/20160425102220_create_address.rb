class CreateAddress < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :city
      t.string :zip_code
      t.string :street_address
    end
  end
end
