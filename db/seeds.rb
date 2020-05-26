# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Post.destroy_all
Post.create(title: 'First post' ,text: 'This is my first post! Hahay!')
Post.create(title: 'Second post' ,text: 'And this is second. Nothing interesting!')
Post.create(title: 'Third post' ,text: 'The third one.')
