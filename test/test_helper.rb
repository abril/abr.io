require 'rubygems'

require 'test/unit'
require 'mocha'
require 'fakeweb'

require 'turn'

FakeWeb.allow_net_connect = false

class Test::Unit::TestCase

  def register_uri(url, options = {})
    fixture = options.delete(:fixture)
    FakeWeb.register_uri(:get, url, :response => File.read("test/fixtures/#{fixture}"))
  end

end

require 'abrio'

module Abrio::Fixtures
  autoload :XmlResponse, "test/fixtures/xml_response"
end

