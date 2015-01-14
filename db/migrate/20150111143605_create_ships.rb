class CreateShips < ActiveRecord::Migration
  def change
    create_table :ships do |t|
      t.references :order, index: true
      t.date :send_date
      t.string :sender
      t.string :express_company
      t.string :express_number
      t.boolean :is_receive

      t.timestamps
    end
  end
end
