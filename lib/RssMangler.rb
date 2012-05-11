require 'rubygems'
require 'bundler/setup'

require 'open-uri'
require 'nokogiri'


class RssMangler

  def initialize uri
    @doc = Nokogiri::Slop(open(uri))
    channel = @doc.html.body.rss.channel
    unless channel.xpath("child::item").empty?
      @items = channel.item.collect do |element|
        ContentItem.new(element)
      end
    else
      @items = []
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
