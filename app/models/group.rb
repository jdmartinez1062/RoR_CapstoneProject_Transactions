class Group < ApplicationRecord
  belongs_to :selected, class_name: :User, inverse_of: :groups

  has_and_belongs_to_many :time_spents, association_foreign_key: :time_log_id, class_name: :TimeSpent,
                                        inverse_of: :groups, join_table: 'groups_times'
  mount_uploader :icon, IconUploader
  validates :name, presence: true, length: { maximum: 20 }
  validates :icon, presence: true

  def group_spents
    time_spents.select('time_spents.id as time_id, time_spents.amount as time_amount,
      time_spents.name as time_name, time_spents.created_at as time_log, users.name as author_name').joins(:author)
  end
end
