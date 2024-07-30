class Diary < ApplicationRecord
  belongs_to :user

  validates :content, presence: true, length: { is: 1 }
  validates :memo, length: { maximum: 255 }
  validates :date, presence: true, uniqueness: { scope: :user_id }
end
