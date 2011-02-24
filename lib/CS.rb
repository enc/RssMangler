require 'rubygems'
require 'bundler/setup'

require 'open-uri'
require 'nokogiri'


class CS

  def initialize uri
    @doc = Nokogiri::HTML(open(uri))
    @items = @doc.css("item").collect do |element|
      ContentItem.new(element)
    end

  end

  def size
    @items.size
  end

  def [] number
    @items[number]
  end

  def each &block
    @items &block
  end
end

class ContentItem
  def initialize item
    @content = item
  end

  def method_missing method, *arg
    if item = @content.css(method.to_s)
      item.text
    end
  end
end
