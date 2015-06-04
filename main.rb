require_relative 'post'


url = ARGV.first

post = Post.new(url)


# puts post.title 

# puts post.item_id

# puts post.points

pp post.item_id
# puts post.points
# puts post.title