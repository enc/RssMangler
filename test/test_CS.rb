# -*- coding: utf-8 -*-
require 'minitest/autorun'
require 'helper'
require 'open-uri'

require 'CS'

class TestCs < MiniTest::Unit::TestCase

  def test_fetch
    stream = CS.new("http://about.podpiska.de/rss-feed-help")
    assert 8, stream.size
    assert stream[0].title, "Как продлевается подписка"
    assert_respond_to stream, :each
  end

  def test_wrong_url
    assert_raises Errno::ENOENT do
      stream = CS.new("not even an url")
    end
  end
end
