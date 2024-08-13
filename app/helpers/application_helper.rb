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
      'text-gray-400'
    else
      'text-black'  # デフォルト
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
end
