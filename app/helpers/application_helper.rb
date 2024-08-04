module ApplicationHelper
  def color_class(mood_color)
    return 'text-black' if mood_color.nil?
    case mood_color
    when 'yellow'
      'text-yellow-400'
    when 'red'
      'text-red-600'
    when 'blue'
      'text-blue-700'
    when 'orange'
      'text-orange-500'
    when 'purple'
      'text-purple-600'
    when 'gray'
      'text-gray-400'
    else
      'text-black'  # デフォルト
    end
  end
end
