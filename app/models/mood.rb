class Mood < ApplicationRecord
  has_many :diaries
  has_one_attached :image
end
