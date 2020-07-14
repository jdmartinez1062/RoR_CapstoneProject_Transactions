# frozen_string_literal: true

class CreateTimeSpents < ActiveRecord::Migration[6.0]
  def change
    create_table :time_spents do |t|
      t.integer :autor_id
      t.string :name
      t.float :amount
      t.datetime :created_at, null: false
    end
    add_index :time_spents, %i[autor_id created_at]
  end
end
