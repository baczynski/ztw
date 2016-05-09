class UpdateAddresses < ActiveRecord::Migration
  def change
    remove_column :players, :address_id, :integer
    add_reference :addresses, :addressable, polymorphic: true, index: true
  end
end
