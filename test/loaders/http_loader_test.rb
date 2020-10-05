require 'test_helper'

class HttpLoaderTest < Minitest::Test
  def subject
    HttpLoader
  end

  def feed
    build(:feed, name: SecureRandom.hex)
  end

  def test_call_client
    expected = Object.new
    client = ->(_url) {}
    client.expects(:call).returns(expected)
    result = subject.call(feed, client: client)
    assert_equal(expected, result)
  end

  def test_success
    client = ->(_url) { '' }
    result = subject.call(feed, client: client)
    assert(result)
  end

  def test_failure
    client = ->(_url) { raise }
    assert_raises(RuntimeError) { subject.call(feed, client: client) }
  end

  def test_default_client_should_raise_on_empty_url
    feed = build(:feed, name: SecureRandom.hex, url: nil)
    assert_raises(ArgumentError) { subject.call(feed) }
  end
end
