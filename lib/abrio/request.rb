require "net/http"
require "uri"

#Wrapper responsible for all requests.
class Abrio::Request

  #Call get at *uri* with *parameters*.
  #[uri] Complete url. Example: http://abr.io/api/links/shorten
  #[parameters] Hash of parameters. Example: {:format => "xml", :version => "1.0"}
  #
  #Returns response body, a String.
  def self.get(uri, parameters)
    params = build_parameters(parameters)

    begin
      url = URI.parse(uri)
      req = Net::HTTP::Get.new("#{url}?#{params}")
      res = Net::HTTP.start(url.host, url.port) do |http|
        http.request(req)
      end
      res.body
    rescue StandardError => e
      raise Abrio::Error.new(e)
    end
  end

  private

  #Receives a Hash.
  #
  #Returns a String in format: "key=value&key2=value2"
  def self.build_parameters(params)
    array_params = []
    params.each_pair { |key, value| array_params << "#{key}=#{value}"}
    array_params.join("&")
  end

end
