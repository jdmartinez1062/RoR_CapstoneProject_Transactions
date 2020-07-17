class Group < ApplicationRecord
  belongs_to :selected, class_name: :User, inverse_of: :groups

  has_and_belongs_to_many :time_spents, association_foreign_key: :time_log_id, class_name: :TimeSpent, inverse_of: :groups, join_table: 'groups_times'
  mount_uploader :icon, IconUploader
  validates :name, presence: true, length: { maximum: 20 }
end
