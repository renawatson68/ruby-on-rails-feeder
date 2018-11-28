require_relative 'normalizer_test'

class NextbigfutureNormalizerTest < NormalizerTest
  def sample_data_file
    'feed_nextbigfuture.xml'
  end

  def processor
    Processors::WordpressProcessor
  end

  def normalizer
    Normalizers::NextbigfutureNormalizer
  end

  def test_sample_data_file_exists
    assert(File.exist?(sample_data_path))
  end

  def test_have_sample_data
    assert(processed.present?)
    assert(processed.length.positive?)
  end

  def test_normalization
    assert(normalized.present?)
    assert_equal(processed.length, normalized.length)
  end

  FIRST_SAMPLE = {
    'link' => 'https://www.nextbigfuture.com/2018/11/rise-of-china-and-strictly-business-competition-in-the-world.html',
    'published_at' => Time.parse('2018-11-27 09:19:49 UTC'),
    'text' => 'Rise of China and Strictly Business Competition in the World - https://www.nextbigfuture.com/2018/11/rise-of-china-and-strictly-business-competition-in-the-world.html',
    'attachments' => ['https://mk0nextbigfuturj5ioe.kinstacdn.com/wp-content/uploads/2018/08/chinaindiausa-730x430.jpeg'],
    'comments' => ['There have been many books written about\\n\\nthe rise of China']
  }.freeze

  def test_normalized_sample
    result = normalized.first.payload
    assert_equal(FIRST_SAMPLE, result)
  end
end