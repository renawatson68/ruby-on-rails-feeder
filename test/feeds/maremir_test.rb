require 'test_helper'

class MaremirTest < Minitest::Test
  include FeedTestHelper

  def feed_config
    {
      name: 'maremir',
      processor: 'rss',
      normalizer: 'maremir',
      url: 'http://maremir.org/feed/'
    }
  end

  def source_fixture_path
    'feeds/maremir.xml'
  end

  def expected_fixture_path
    'entities/maremir.json'
  end
end
