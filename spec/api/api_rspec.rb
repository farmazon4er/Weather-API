require 'rails_helper'

describe API do
  context 'GET /health' do
    it 'returns an ok' do
      get '/health'
      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)).to eq ({"status"=>"OK"})
    end
  end

  context 'GET /weather/current' do
    it 'returns an current temp' do
      get '/weather/current'
      expect(response.status).to eq(200)
      #      expect(JSON.parse(response.body)).to eq ()
    end
  end

  context 'GET /historical/' do
    it 'returns an /historical/' do
      get '/weather/historical'
      expect(response.status).to eq(200)
      #      expect(JSON.parse(response.body)).to eq ()
    end
    it 'returns an /historical/max' do
      get '/weather/historical/max'
      expect(response.status).to eq(200)
      #      expect(JSON.parse(response.body)).to eq ()
    end

    it 'returns an /historical/min' do
      get '/weather/historical/min'
      expect(response.status).to eq(200)
      #      expect(JSON.parse(response.body)).to eq ()
    end

    it 'returns an /historical/avg' do
      get '/weather/historical/avg'
      expect(response.status).to eq(200)
      #      expect(JSON.parse(response.body)).to eq ()
    end

  end

end