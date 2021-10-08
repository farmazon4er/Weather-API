require 'json'
require 'vcr'

Class API
def current_weather
  VCR.use_cassette("synopsis") do
    response = Net::HTTP.get_response(URI('http://dataservice.accuweather.com/currentconditions/v1/476430_PC?apikey=CIXpye68tOePjMJ1BQTAd4wjWa7gj2hA'))
    assert_match /Example domains/, response.body
  end

end

