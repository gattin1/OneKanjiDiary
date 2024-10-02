# frozen_string_literal: true

# OGP画像を生成するためのクラス
class OgpCreator
  require 'mini_magick'
  BASE_IMAGE_PATH = './app/assets/images/sns_ogp.png'
  GRAVITY = 'center'
  TEXT_POSITION = '0,-30'
  FONT = './app/assets/fonts/YujiMai-Regular.ttf'
  FONT_SIZE = 350
  INDENTION_COUNT = 16
  ROW_LIMIT = 8

  def self.build(text)
    text = prepare_text(text)
    image = MiniMagick::Image.open(BASE_IMAGE_PATH)
    image.combine_options do |config|
      config.font FONT
      config.fill 'black'
      config.gravity GRAVITY
      config.pointsize FONT_SIZE
      config.draw "text #{TEXT_POSITION} '#{text}'"
    end
  end

  def self.prepare_text(text)
    text.to_s.scan(/.{1,#{INDENTION_COUNT}}/)[0...ROW_LIMIT].join("\n")
  end
end
