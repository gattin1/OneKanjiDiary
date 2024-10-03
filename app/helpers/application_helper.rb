# frozen_string_literal: true

# 日記の気分を設定するモジュール
module ApplicationHelper
  def color_class(mood_color)
    return 'text-black' if mood_color.nil?

    case mood_color
    when 'yellow'
      'text-yellow-300'
    when 'red'
      'text-red-600'
    when 'blue'
      'text-blue-700'
    when 'orange'
      'text-orange-500'
    when 'gray'
      'text-gray-500'
    else
      'text-black' # デフォルト
    end
  end

  MOOD_IMAGES = {
    'yellow' => 'yellow_image.png',
    'red' => 'red_image.png',
    'blue' => 'blue_image.png',
    'orange' => 'orange_image.png',
    'gray' => 'gray_image.png'
  }.freeze

  def mood_image_for(color)
    MOOD_IMAGES[color] || 'default_image.png'
  end

  def default_meta_tags
    {
      site: '詐欺師の手帳',
      title: '詐欺師の手帳',
      reverse: true,
      charset: 'utf-8',
      description: '詐欺被害の未然防止を目的としたアプリです',
      canonical: root_url,
      og: {
        site_name: '詐欺師の手帳',
        title: '詐欺師の手帳',
        description: '詐欺被害の未然防止を目的としたアプリです',
        type: 'website',
        url: request.original_url,
        image: image_url('sns_ogp.png'),
        local: 'ja-JP'
      },
      twitter: {
        card: 'summary_large_image',
        site: '@https://x.com/yukimura877',
        image: image_url('default_share.png')
      }
    }
  end
end
