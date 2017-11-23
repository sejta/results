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
comand = []

  @results = data.css('.table.table-striped.recent-esports-matches.series-table.narrow').each do |result|
    result.css('tbody').each_with_index do  |name, index|
      @indexplus = index
      @scored = name.css('.winner.series-winner').map {|scored| scored.text}
      @teamone = name.css('.team.team-1').css('.team-text.team-text-full').map {|teamone| teamone.text}
      @teamtwo = name.css('.team.team-2').css('.team-text.team-text-full').map {|teamtwo| teamtwo.text}
      comand.push(
                teamone: @teamone,
                scored: @scored,
                teamtwo: @teamtwo
      )
    end
  end
@timeout = JSON.pretty_generate(comand)

    erb :resm
end



