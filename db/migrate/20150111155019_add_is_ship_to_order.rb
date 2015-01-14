class AddIsShipToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :is_ship, :boolean, default: false
  end
end
