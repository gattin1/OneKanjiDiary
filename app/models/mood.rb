# frozen_string_literal: true

# 気分に関するモデル
class Mood < ApplicationRecord
  has_many :diaries, dependent: :destroy
  has_one_attached :image

  def self.colors_by_name
    pluck(:name, :color).to_h
  end
end
