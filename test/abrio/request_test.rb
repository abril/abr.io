require 'test_helper'

class Abrio::RequestTest < Test::Unit::TestCase

  def test_get_request
    register_uri("http://abr.io/api/links/shorten?param=value", :fixture => "shorten_success")

    uri = "http://abr.io/api/links/shorten"
    params = {:param => "value"}

    response_body = Abrio::Request.get(uri, params)
    assert_match(/<abrio>/, response_body, "Response should start with <abrio>")
  end

  def test_get_invalid_request

    Net::HTTP.expects(:start).with("invalid.com", 80).raises(ArgumentError)
    assert_raise Abrio::Error do
      Abrio::Request.get("http://invalid.com", {})
    end

  end

end
