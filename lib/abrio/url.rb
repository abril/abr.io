require 'rexml/document'

#Represents Abrio API response.
class Abrio::Url

  attr_reader :status_code, :error_message, :error_code
  attr_reader :short_url

  #Initialize all read-only atributes with Hash.
  def initialize(attrs = {})
    attrs.each_pair do |attr, value|
      self.instance_variable_set("@#{attr}", value)
    end
  end

  #Parses *xml* from Abrio API.
  #
  #See documentation at http://abr.io/pages/api
  def self.parse(xml_body)
    validates_xml(xml_body)

    doc = REXML::Document.new(xml_body)

    attributes = {:status_code => doc.elements["*/statusCode"].text,
                  :error_message => doc.elements["*/errorMessage"].text,
                  :error_code => doc.elements["*/errorCode"].text}

    if (result = doc.elements["*/results/nodeKeyVal"])
      attributes.merge!({:short_url => result.elements["shortUrl"].text})
    end
    self.new(attributes)
  end

  def self.validates_xml(xml)
    raise Abrio::Error.new("XML body cannot be blank") if xml.nil? || xml.empty?
    raise Abrio::Error.new("Does not appear to be a valid Abrio XML.\n\n#{xml}") unless xml.start_with?("<abrio>")
  end

end
