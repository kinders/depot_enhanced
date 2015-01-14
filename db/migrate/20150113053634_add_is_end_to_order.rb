class AddIsEndToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :is_end, :boolean, default: :false
  end
end
