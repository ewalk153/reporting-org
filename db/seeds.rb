# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
words = File.open("/usr/share/dict/words").readlines.map(&:strip)
0.upto(1000).each do |i|
  manager_id = i == 0 ? nil : 1 + (Random.rand * (i-1)).round
  User.create(
    email: "#{words.sample}@example.com",
    name: "#{words.sample} #{words.sample}",
    manager_id: manager_id,
  )
end