require 'sinatra'
require 'sinatra/bootstrap'
require 'nokogiri'
require 'open-uri'
require 'openssl'
require 'json'

OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

register Sinatra::Bootstrap::Assets


get '/start' do
  site = 'https://www.dotabuff.com/esports'

  data = Nokogiri::HTML(open(site))

  @results = data.css('.table.table-striped.recent-esports-matches.series-table.narrow').css('tr')


    erb :resm
end

get '/result' do
  erb :resultjson
end

post '/resultjson' do
  @match = (params[:matchid].to_s)


  url = 'https://api.opendota.com/api/matches/'


  c = url + @match
  puts c



  @result = JSON.parse(open(c).read)
  @sec = @result['duration'].to_i
  @duration = Time.at(@sec).utc.strftime("%H:%M:%S")




  erb :resultjson
end

