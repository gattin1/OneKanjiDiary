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

  def prepare_meta_tags(diary = nil)
    if diary.present?
      # 日記の詳細ページ用のメタ情報を生成（URLはroot_urlを使用）
       title = "今日の私の一文字は\"#{diary.title}\"です"
    description = '一文字日記　今日の一日を漢字一文字で。'
      image_url = "#{request.base_url}/images/ogp.png?text=#{CGI.escape(diary.title)}"
      url = root_url  # 常にトップページにリダイレクト
    else
      # トップページや他のページ用のメタタグ設定
      title = '一文字日記'
      description = 'あなたの日々を一文字で表現する日記アプリ'
      image_url = "#{request.base_url}/images/default_ogp.png"
      url = root_url
    end

    meta_tags = {
      site: '一文字日記',
      title: title,
      description: description,
      type: 'website',
      url: url,  # 常にトップページ
      image: image_url,
      locale: 'ja-JP'
    }

    set_meta_tags og: meta_tags, twitter: meta_tags.merge(card: 'summary_large_image')
  end
end
