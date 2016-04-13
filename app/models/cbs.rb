class CBS
  def self.cbsCreatePlayercards
    rankings = JSON.parse(playerRanking())['body']['rankings']['positions']
    rankings.each do |position|
      if position['abbr'] = ("C" or "1B" or "2B" or "3B" or "SS" or "OF")
        position['players'].each do |player|
          puts player['rank'].to_s + ' ' + player['firstname'] + ' ' + player['lastname'] + ' ' + position['abbr'] + ' ' + player['id']
        end
      end
    end
  end

  def self.playerRanking
    uri = URI("http://api.cbssports.com/fantasy/players/rankings?version=3.0&response_format=JSON&SPORT=baseball")
    Net::HTTP.get(uri)
  end

  def self.cbsRanking
    rankings = JSON.parse(playerRanking())['body']['rankings']['positions']
    rankings.each do |position|
      position['players'].each do |player|
        puts player['rank'].to_s + ' ' + player['fullname'] + ' ' + player['position'] + ' ' + player['id']
      end
    end
  end

end
