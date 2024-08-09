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
mood1.image.attach(io: File.open(Rails.root.join('db/seeds/images/yellow_image.png')), filename: 'yellow_image.png')
mood2 = Mood.create(name: '怒り', color: 'red')
mood2.image.attach(io: File.open(Rails.root.join('db/seeds/images/red_image.png')), filename: 'red_image.png')
mood3 = Mood.create(name: '哀しみ', color: 'blue')
mood3.image.attach(io: File.open(Rails.root.join('db/seeds/images/blue_image.png')), filename: 'blue_image.png')
mood4 = Mood.create(name: '幸せ', color: 'orange')
mood4.image.attach(io: File.open(Rails.root.join('db/seeds/images/orange_image.png')), filename: 'orange_image.png')
mood5 = Mood.create(name: '無', color: 'gray')
mood5.image.attach(io: File.open(Rails.root.join('db/seeds/images/gray_image.png')), filename: 'gray_image.png')
