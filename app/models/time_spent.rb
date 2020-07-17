class TimeSpent < ApplicationRecord
  belongs_to :author, class_name: :User, foreign_key: :author_id, inverse_of: :time_spents
  has_and_belongs_to_many :groups, join_table: 'groups_times', foreing_key: :time_log_id

  scope :ordered_by_most_recent, -> { order(created_at: :desc) }

  def self.external
    where(<<-SQL)
      NOT EXISTS (SELECT 1 
        FROM   groups_times 
        WHERE  time_spents.id = groups_times.time_log_id) 
    SQL
  end
  validates :name, presence: true, length: { maximum: 20 }
  validates :amount, presence: true, numericality: { less_than_or_equal_to: 24 }

  def total
    calculate(:sum, :amount)
  end
end
