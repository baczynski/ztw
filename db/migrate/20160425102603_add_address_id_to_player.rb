class AddAddressIdToPlayer < ActiveRecord::Migration
  def change
    add_reference :players, :address, index: true, foreign_key: true
  end
end
