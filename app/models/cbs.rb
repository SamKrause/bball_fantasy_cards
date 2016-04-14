class CBS

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
  #Code for Creating Playercards from CBS API
  # def self.cbsCreatePlayercards
  #   rankings = JSON.parse(playerRanking())['body']['rankings']['positions']
  #   rankings.each do |position|
  #     if position.has_value?("C") or position.has_value?("1B") or position.has_value?("2B") or position.has_value?("3B") or position.has_value?("SS") or position.has_value?("OF")
  #       puts position['abbr']
  #       position['players'].each do |player|
  #         puts player['rank'].to_s + ' ' + player['firstname'] + ' ' + player['lastname'] + ' ' + position['abbr'] + ' ' + player['id']
  #         Playercard.create(first_name: player['firstname'], last_name: player['lastname'], position: position['abbr'], rank: player['rank'], cbs_id: player['id'].to_i)
  #       end
  #     end
  #   end
  # end
