# -*- coding: utf-8 -*-
require 'minitest/autorun'
require 'helper'
require 'open-uri'

require 'RssMangler'

class TestRssMangler < MiniTest::Unit::TestCase

  def test_fetch
    stream = RssMangler.new("http://about.podpiska.de/rss-feed-help")
    assert 8, stream.size
    assert stream[0].title, "Как продлевается подписка"
    assert stream[0].non_existen, ""
    assert_respond_to stream, :each
  end

  def test_empty
    assert RssMangler.new("http://about.podpiska.de/rss-feed-promotions/").size, 0
  end

  def test_wrong_url
    assert_raises Errno::ENOENT do
      stream = RssMangler.new("not even an url")
    end
  end
end
