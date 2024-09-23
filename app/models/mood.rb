class Mood < ApplicationRecord
  has_many :diaries
  has_one_attached :image

  def self.colors_by_name
    pluck(:name, :color).to_h
  end
end
