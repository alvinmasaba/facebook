puts "Seeding database with users..."

USERS = ["Alvin Masaba", "Kobe Bufkin", "Jaime Jacquez",
         "Jett Howard", "Marcus Sasser", "Brice Sensabough",
         "Colby Jones", "Jalen Pickett", "Julian Strawther"]

USERS.each do |u|
  name = u.split
  User.create! first_name: name[0], last_name: name[1], email: "#{name[0].downcase}@gmail.com", password: 'masaba', password_confirmation: 'masaba'
end

puts "Seeding complete!"