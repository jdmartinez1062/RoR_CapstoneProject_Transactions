# frozen_string_literal: true

class User < ApplicationRecord
  has_many :time_spents
  has_many :groups

  validates :name, presence: true, length: { maximum: 20 }
end
