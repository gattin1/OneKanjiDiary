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
mood1 = Mood.create(name: '嬉しい', color: 'yellow')
mood2 = Mood.create(name: '怒り', color: 'red')
mood3 = Mood.create(name: '哀しみ', color: 'blue')
mood4 = Mood.create(name: '幸せ', color: 'orange')
mood5 = Mood.create(name: '無', color: 'gray')
