require 'test_helper'

class AbrioTest < Test::Unit::TestCase

  def test_setup
    Abrio.setup do |client|
      client.uri = "http://abr.io/api/links"
      client.login = "login"
      client.key = "key"
    end

    assert_equal "http://abr.io/api/links", Abrio.client.uri
    assert_equal "login", Abrio.client.login
    assert_equal "key", Abrio.client.key
  end

  def test_shorten
    client = mock() do
      expects(:shorten).with("google.com", {}).returns("OK")
    end
    Abrio.expects(:client).returns(client)

    result = Abrio.shorten("google.com")
    assert_equal "OK", result
  end

end
