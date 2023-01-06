puts "Seeding database with users..."

User.delete_all

USERS = ["Alvin Masaba", "Francis Masaba", "Stephanie Masaba",
         "Trevor Masaba", "Cassandra Marambio", "Nick Kerr", "Steve Nash",
         "LeBron James", "Pascal Siakam", "Chat GPT3"]

USERS.each do |u|
  name = u.split
  UserManager::User.create(name: name[0], surname: name[1], email: "#{name[0].downcase}@gmail.com", password: 'masaba', password_confirmation: 'masaba')
end