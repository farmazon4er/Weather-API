require 'grape-swagger'
require 'net/http'
require 'json'

def accu_weather(uri)
  api_key = '?apikey=JdQEV7fG79uW7IPiKb7DjkgfhMd5JrLn'
  url = URI.parse(uri + api_key)
  req = Net::HTTP::Get.new(url.to_s)
  res = Net::HTTP.start(url.host, url.port) {|http|
    http.request(req)
  }
  JSON.parse(res.body)
end

class API < Grape::API
  format :json

  # GET /health
  get 'health' do
    { status: 'OK' }
  end
  # GET /weather/
  namespace 'weather' do
    get '/current' do
      # наличие первой записи и обновление раз в 10 минут.
      if (!CurrentTemp.last.present?) || (CurrentTemp.last.created_at + 600 < Time.now)
        body_hash = accu_weather('http://dataservice.accuweather.com/currentconditions/v1/476430_PC')
        temp = body_hash[0]['Temperature']['Metric']['Value']
        current = CurrentTemp.new(temp: temp)
        current.save
      else
        current = CurrentTemp.last
      end
      { Temperature: current.temp }
    end
    # GET /historical/
    namespace 'historical' do
      if (!Historical.last.present?) || (Historical.last.created_at + 600 < Time.now)
        body_hash = accu_weather('http://dataservice.accuweather.com/currentconditions/v1/476430_PC/historical/24')
        temperature = (0..23).collect{|i| body_hash[i]['Temperature']['Metric']['Value'] }
        hist = Historical.new(temp: temperature)
        hist.save
      else
        hist = Historical.last
      end
      get '/' do
        { Temperature: hist.temp }
      end
      get '/max' do
        { Temperature: hist.temp.max }
      end
      get '/min' do
        { Temperature: hist.temp.min }
      end
      get '/avg' do
        avg = (hist.temp.inject{ |sum,el| sum + el}.to_f / 24).round(2)
        { Temperature: avg }
      end
    end
    get '/by_time' do
      time = params[:timestamp].to_i
      { Temperature: Time.at(time) }
    end
  end

  # Swagger docs
  add_swagger_documentation
end

