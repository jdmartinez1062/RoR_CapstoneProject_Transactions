# frozen_string_literal: true

class CreateGroups < ActiveRecord::Migration[6.0]
  def change
    create_table :groups do |t|
      t.string :name
      t.integer :selected_id
      t.string :icon
      t.datetime :created_at, null: false
    end
    add_index :groups, :selected_id
  end
end
