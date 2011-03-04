require 'rubygems'
require 'bundler/setup'

require 'open-uri'
require 'nokogiri'


class RssMangler

  def initialize uri
    @doc = Nokogiri::Slop(open(uri))
    @items = @doc.html.body.rss.channel.item.collect do |element|
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
    @items.each &block
  end
end

class ContentItem
  def initialize item
    @content = item
  end

  def method_missing method, *arg
    begin
      @content.send(method).text
    rescue NoMethodError
      ""
    end
  end
end
