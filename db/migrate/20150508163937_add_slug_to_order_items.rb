class AddSlugToOrderItems < ActiveRecord::Migration
  def change
    add_column :order_items, :slug, :string
    add_index :order_items, :slug, unique: true
  end
end
