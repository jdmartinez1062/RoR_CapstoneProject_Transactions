class User < ApplicationRecord
  has_many :time_spents, foreign_key: :author_id

  has_many :groups, foreign_key: :selected_id
  mount_uploader :avatar, AvatarUploader
  validates :name, presence: true, length: { maximum: 20 }, uniqueness: { case_sensitive: false }
  validates :avatar, presence: true

  def external_time_spents
    TimeSpent.external.select('time_spents.id as time_id, time_spents.amount as time_amount,
      time_spents.name as time_name, time_spents.created_at as time_log').where(author_id: id)
  end

  def group_time_spents
    groups.select('groups.*, time_spents.id as time_id, time_spents.amount as time_amount,
       time_spents.name as time_name, time_spents.created_at as time_log').joins(:time_spents)
  end
end
