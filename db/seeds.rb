Post.destroy_all

50.times do |i|
  Post.create(
    title: "Boring post number #{i}",
    text: Faker::Lorem.paragraph
  )
end
