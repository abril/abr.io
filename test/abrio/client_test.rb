require 'test_helper'

class Abrio::ClientTest < Test::Unit::TestCase

  include Abrio::Fixtures::XmlResponse
  DEFAULT_EXPECTED_PARAMS = {:longUrl => 'http://google.com', :version => '1.0', :format => 'xml', :key => 'Z_VALID', :login => 'rogleite'}

  def test_default_configurations
    assert_equal "http://abr.io/api/links", Abrio::Client.new.uri
  end

  def test_shorten_with_blank_value
    client = Abrio::Client.new
    assert_equal nil, client.shorten(nil)
    assert_equal nil, client.shorten("")
  end

  def test_shorten_with_valid_value
    client = Abrio::Client.new(:login => "rogleite", :key => "Z_VALID")

    Abrio::Request.expects(:get).with("#{client.uri}/shorten", DEFAULT_EXPECTED_PARAMS).returns(abrio_success_xml)

    abrio_url = client.shorten("http://google.com")
    assert_not_nil abrio_url, "expects a Abrio::Url"
    assert_equal "http://abr.io/18VN", abrio_url.short_url
  end

  def test_shorten_options_parameter
    client = Abrio::Client.new(:login => "rogleite", :key => "Z_VALID")

    expected_params = DEFAULT_EXPECTED_PARAMS.merge({:key => 'Z_OPTION', :login => 'login'})
    Abrio::Request.expects(:get).with("http://abr.io/api/links/shorten", expected_params).returns(abrio_success_xml)

    abrio_url = client.shorten("http://google.com", :uri => "http://abr.io/api/links", :login => "login", :key => "Z_OPTION")
    assert_not_nil abrio_url, "expects a Abrio::Url"
    assert_equal "OK", abrio_url.status_code
  end

  def test_shorten_failure
    client = Abrio::Client.new(:login => "rogleite", :key => "Z_INVALID")

    expected_params = DEFAULT_EXPECTED_PARAMS.merge({:key => 'Z_INVALID'})
    Abrio::Request.expects(:get).with("#{client.uri}/shorten", expected_params).returns(abrio_error_xml)

    abrio_url = client.shorten("http://google.com")
    assert_not_nil abrio_url, "expects a Abrio::Url"
    assert_equal "ERROR", abrio_url.status_code
    assert_nil abrio_url.short_url
  end

  def test_shorten_net_http_error
    expected_params = DEFAULT_EXPECTED_PARAMS.merge({:key => 'Z_INVALID'})
    Abrio::Request.expects(:get).with("http://nonexist/shorten", expected_params).raises(Abrio::Error, "Net fake error")

    client = Abrio::Client.new(:login => "rogleite", :key => "Z_INVALID")
    abrio_url = client.shorten("http://google.com", :uri => "http://nonexist")

    assert_not_nil abrio_url, "expects a Abrio::Url"
    assert_equal "ERROR", abrio_url.status_code
    assert_nil abrio_url.short_url
  end

end
