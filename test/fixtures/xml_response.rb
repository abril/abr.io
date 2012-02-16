module Abrio

module Fixtures

  module XmlResponse

    def abrio_success_xml
<<XML
<abrio>
  <errorCode>0</errorCode>
  <errorMessage></errorMessage>
  <results>
    <nodeKeyVal>
      <userHash>18VN</userHash>
      <shortKeywordUrl></shortKeywordUrl>
      <hash>3u</hash>
      <nodeKey>
        <![CDATA[http://google.com]]>
      </nodeKey>
      <shortUrl>http://abr.io/18VN</shortUrl>
    </nodeKeyVal>
  </results>
  <statusCode>OK</statusCode>
</abrio>
XML
    end

    def abrio_error_xml
<<XML
<abrio>
	<errorCode>203</errorCode>
	<errorMessage>You must be authenticated to access shorten.</errorMessage>
	<statusCode>ERROR</statusCode>
</abrio>
XML
    end

  end
end

end
