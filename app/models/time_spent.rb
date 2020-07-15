class TimeSpent < ApplicationRecord
  belongs_to :author, class_name: :User, foreign_key: :author_id, inverse_of: :time_spents
  has_and_belongs_to_many :groups, join_table: 'groups_times', foreing_key: :time_log_id

  validates :name, presence: true, length: { maximum: 20 }
  validates :amount, presence: true, numericality: { less_than_or_equal_to: 24 }
end
