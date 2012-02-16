require 'test_helper'

class Abrio::UrlTest < Test::Unit::TestCase

  include Abrio::Fixtures::XmlResponse

  def assert_success_url(url, attrs)
    assert_not_nil url
    assert_equal "0", url.error_code
    assert_equal "OK", url.status_code
    assert_equal attrs[:short_url], url.short_url
  end

  def assert_error_url(url, code, message)
    assert_not_nil url
    assert_equal code, url.error_code
    assert_equal message, url.error_message
    assert_equal "ERROR", url.status_code
    assert_equal nil, url.short_url
  end

  def test_parse_abrio_success_xml
    url = Abrio::Url.parse(abrio_success_xml)
    assert_success_url url, :short_url => "http://abr.io/18VN"
  end

  def test_parse_abrio_error_xml
    url = Abrio::Url.parse(abrio_error_xml)
    assert_error_url url, "203", "You must be authenticated to access shorten."
  end

  def test_parse_blank_xml
    assert_raise Abrio::Error do
      Abrio::Url.parse(nil)
    end
    assert_raise Abrio::Error do
      Abrio::Url.parse("")
    end
  end

  def test_parse_should_check_for_root_tags
    assert_raise Abrio::Error do
      Abrio::Url.parse("<h1>Some Error</h1>")
    end
  end

end
