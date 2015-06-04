require 'nokogiri'
require 'pry'
require 'open-uri'




class Post
  attr_reader :title, :url, :points, :item_id, :url_object, :comments

  def initialize(url)

    @url = url
    @url_object = Nokogiri::HTML(open(url))

    @title = url_object.search('.title a').inner_text
    @url = url
    @points = url_object.search('.subtext > span:first-child').map { |span| span.inner_text}
    @item_id = url_object.search('.subtext > a:nth-child(3)').map {|link| link['href'] }

    @comments = []

    url_object.search('.default').each do |raw_c|
      user = raw_c.search('.comhead a:first-child').inner_text
      text = raw_c.search('.comment > font:first-child').inner_text

      add_comment(user, text)
    end
    # puts "Title: #{title}"
    # comment_counter
    # top_comment

  end

  def comments
    @comments
  end

  def comment_counter
    puts "Numbero of comments: #{comments.length}"
  end

  def top_comment
    puts "Top comment written by #{self.comments[0].user}"
    puts " '#{self.comments[0].text}' "
  end

  def add_comment(user, text)
    @comments << Comment.new(user, text)
  end




end

class Comment
  attr_accessor :text 
  attr_reader :user



  def initialize(user, text)
  @user = user
  @text = text
  end



end