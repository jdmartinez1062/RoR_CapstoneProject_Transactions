class User < ApplicationRecord
  has_many :time_spents, foreign_key: :author_id
  has_many :groups, foreign_key: :selected_id

  validates :name, presence: true, length: { maximum: 20 }
end
