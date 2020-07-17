class User < ApplicationRecord
  has_many :time_spents, foreign_key: :author_id

  # has_many :user_spents, -> { where 'name != external' }, foreign_key: :author_id, class_name: :TimeSpent
  # has_many :external_spents, -> { where name: 'external' }, foreign_key: :author_id, class_name: :TimeSpent
  has_many :groups, foreign_key: :selected_id
  validates :name, presence: true, length: { maximum: 20 }, uniqueness: { case_sensitive: false }

  def external_time_spents
    external_times = TimeSpent.external
    external_times.where(author_id: id).map(&:amount)
  end

  def group_time_spents
    groups.include(:time_spents).time_spents.map(&:amount)
  end
end
