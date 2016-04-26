class AddFirstNameSurnameDateOfBirthToPlayer < ActiveRecord::Migration
  def change
    add_column :players, :first_name, :string
    add_column :players, :surname, :string
    add_column :players, :date_of_birth, :date
  end
end
