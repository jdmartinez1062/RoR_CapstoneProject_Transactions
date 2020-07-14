# frozen_string_literal: true

class CreateGroupTimeTable < ActiveRecord::Migration[6.0]
  def change
    create_table :groups_times, id: false do |t|
      t.integer :group_id
      t.integer :time_log_id
    end
  end
end
