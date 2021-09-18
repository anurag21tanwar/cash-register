# frozen_string_literal: true

class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.integer :quantity, default: 1, null: false
      t.integer :product_id
      t.integer :basket_id

      t.timestamps

      t.index :product_id
      t.index :basket_id
    end
  end
end
