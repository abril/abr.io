#Client proxy for Abr.io API.
class Abrio::Client

  attr_accessor :uri, :login, :key

  DEFAULT_PARAMS = {:format => "xml", :version => "1.0"}

  #Use the following options to initialize your client:
  #  [uri] - Default: "abr.io/api/links"
  #  [login] - Your login from Abr.io. See: http://abr.io/pages/api
  #  [key] - Your key from Abr.io. See: http://abr.io/pages/api
  def initialize(options = {})
    @uri = options[:uri] || "http://abr.io/api/links"
    @login = options[:login]
    @key = options[:key]
  end

  #Shorten an url.
  #[long_url] url you want to shorten.
  #[options] Optional Hash. You can pass the following keys:
  #  [uri] - Default: "abr.io/api/links"
  #  [login] - Your login from Abr.io. See: http://abr.io/pages/api
  #  [key] - Your key from Abr.io. See: http://abr.io/pages/api
  def shorten(long_url, options = {})
    return nil if long_url.nil? || long_url == ""

    @uri = options.delete(:uri) || @uri
    params = {:login => options.delete(:login) || @login,
              :key   => options.delete(:key) || @key}.merge(DEFAULT_PARAMS)
    params[:longUrl] = long_url

    begin
      response = Abrio::Request.get("#{self.uri}/shorten", params)
      Abrio::Url.parse(response)
    rescue Abrio::Error => e
      Abrio::Url.new(:status_code => "ERROR", :errorMessage => e.message, :error_code => -1)
    end
  end

end
