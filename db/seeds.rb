# frozen_string_literal: true

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
Mood.create(name: '喜', color: 'yellow')
Mood.create(name: '怒', color: 'red')
Mood.create(name: '哀', color: 'blue')
Mood.create(name: '楽', color: 'orange')
Mood.create(name: '驚', color: 'purple')
Mood.create(name: '無', color: 'gray')
