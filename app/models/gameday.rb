class Gameday

  def self.setTeam
    Playercard.where("pro_team_name = ?", "SEA").each do |player|
      player.update(pro_team_city: "Seattle", pro_team_name: "Mariners")
    end
    Playercard.where("pro_team_name = ?", "MIN").each do |player|
      player.update(pro_team_city: "Minnesota", pro_team_name: "Twins")
    end

  end

  def self.playerNames
    players = yesterdaysPlayers()
    players.each do |player|
      puts player[:name] + " " + player[:id]
    end
  end

  def self.yesterdaysPlayers
    game_array = yesterdaysGames()
    player_array = []
    game_array.each do |game|
      uri = URI("http://gd2.mlb.com" + game + "/players.xml")
      xml_doc = Nokogiri::XML(Net::HTTP.get(uri))
      xml_doc.css('game team player').each do |player|
        stats = batterStats(player['id'])
        data = {name: player['first'] + ' ' + player['last'], id: player['id'], team: player['team_abbrev']}
        hash = data.merge!(stats)
        player_array.push(hash)
      end
    end
    return player_array
  end

  def self.batterStats(player_id)
    date = Date.yesterday
    uri = URI("http://gd2.mlb.com/components/game/mlb/year_" + date.to_s(:year) + "/month_" + date.to_s(:month) + "/day_" + date.to_s(:day) + "/batters/"+ player_id + "_1.xml")
    xml_doc = Nokogiri::XML(Net::HTTP.get(uri))
    bs = xml_doc.css('batting')[0]
    stats_hash = {at_bat: bs['ab'], hit: bs['h'], single: bs['single'], double: bs['double'], triple: bs['triple'], home_run: bs['hr'], walk: bs['bb'], rbi: bs['rbi'], so: bs['so']}
    return stats_hash
  end

  def self.yesterdaysGames
    date = Date.yesterday
    generateGameDirectoriesArray(date.to_s(:year), date.to_s(:month), date.to_s(:day))
  end

  def self.todaysGames
    date = Date.today
    generateGameDirectoriesArray(date.to_s(:year), date.to_s(:month), date.to_s(:day))
  end

  def self.generateGameDirectoriesArray (year, month, day)
    uri = URI("http://gd2.mlb.com/components/game/mlb/year_" + year +"/month_" + month + "/day_" + day + "/epg.xml")
    response = Net::HTTP.get(uri)
    xml_doc  = Nokogiri::XML(response)
    game_array = []
    xml_doc.css('epg game').each do |game|
      game_array.push(game['game_data_directory'])
    end
    return game_array
  end


end
  #Code for Updating Playercards with infor from Gameday API
  # def self.updatePlayercards
  #   game_array = generateGameDirectoriesArray("2016", "04", "05")
  #   player_array = []
  #   game_array.each do |game|
  #     uri = URI("http://gd2.mlb.com" + game + "/players.xml")
  #     xml_doc = Nokogiri::XML(Net::HTTP.get(uri))
  #     xml_doc.css('game team player').each do |player|
  #       playercard = Playercard.where("first_name = ? AND last_name = ?", player['first'], player['last'])
  #       if !playercard[0].nil?
  #         playercard[0].update(pro_team_name: player['team_abbrev'], number: player['num'].to_i, gameday_id: player['id'].to_i)
  #       end
  #     end
  #   end
  # end
