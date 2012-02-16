module Abrio
  autoload :Client, "abrio/client"
  autoload :Request, "abrio/request"
  autoload :Url, "abrio/url"
  autoload :Error, "abrio/error"

  # Useful to set Abrio client parameters.
  #
  #     Abrio.setup do |client|
  #       client.uri = "http://abr.io/api/links"
  #       client.login = "login"
  #       client.key = "key"
  #     end
  #
  def self.setup
    yield(client) if block_given?
  end

  # Shortcut to Abrio::Client.shorten
  def self.shorten(long_url, options = {})
    client.shorten(long_url, options)
  end

  protected

  #Returns Abrio::Client instance
  def self.client
    @@client ||= Client.new
  end

end
