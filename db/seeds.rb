Post.destroy_all

Post.create(title: 'First post' , text: 'This is my first post! Hahay!')
Post.create(title: 'Second post' , text: 'And this is second. Nothing interesting!')
Post.create(title: 'Third post' , text: 'The third one.')

# And many other boring posts
(4..50).each do |i|
  Post.create(title: "Post number #{i}", text: "Text of post number #{i}.")
end
