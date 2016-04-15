class Gameday

  def self.createPlayerYesterdayStats
    Playercard.select(:gameday_id, :id).each do |player|
      player_stats = batterStats(player.gameday_id.to_s)
      fantasy_points = calculateFantasyPoints(player_stats)
      DayStat.create(date: Date.yesterday.to_s(:db), ab: player_stats[:ab].to_i, h: player_stats[:h].to_i, bb: player_stats[:bb].to_i, so: player_stats[:so].to_i, r: player_stats[:r].to_i, sb: player_stats[:sb].to_i, hr: player_stats[:hr].to_i, rbi: player_stats[:rbi].to_i, single: player_stats[:single].to_i, double: player_stats[:double].to_i, triple: player_stats[:triple].to_i, fantasy_points: fantasy_points, playercard_id: player.id, hbp: player_stats[:hbp].to_i)
    end
  end

  def self.updatePlayersSeasonStats
    game_array = yesterdaysGames()
    Playercard.select(:gameday_id, :id, :first_name, :last_name).each do |player|
      game_array.each do |game|
        uri = URI("http://gd2.mlb.com" + game + "/batters/" + player.gameday_id.to_s + ".xml")
        response = Net::HTTP.get(uri)
        if response != "GameDay - 404 Not Found"
          xml_doc = Nokogiri::XML(response)
          puts "Found player " + player.first_name + ' ' + player.last_name
          stats = xml_doc.css('season')[0]
          SeasonStat.where('playercard_id = ? AND year = ?', player.id, 2016)[0].update(avg: stats['avg'].to_f, ab: stats['ab'].to_i, h: stats['h'].to_i, bb: stats['bb'].to_i, so: stats['so'].to_i, r: stats['r'].to_i, sb: stats['sb'].to_i, hr: stats['hr'].to_i, rbi: stats['rbi'].to_i)
        end
      end
    end
  end

  def self.batterStats(gameday_id)
    date = Date.yesterday
    uri = URI("http://gd2.mlb.com/components/game/mlb/year_" + date.to_s(:year) + "/month_" + date.to_s(:month) + "/day_" + date.to_s(:day) + "/batters/"+ gameday_id + "_1.xml")
    xml_doc = Nokogiri::XML(Net::HTTP.get(uri))
    bs = xml_doc.css('batting')[0]
    if bs.nil?
      stats_hash = {ab: 0, h: 0, single: 0, double: 0, triple: 0, hr: 0, bb: 0, rbi: 0, so: 0, avg: 0, r: 0, sb: 0, hbp: 0}
    else
      stats_hash = {ab: bs['ab'], h: bs['h'], single: bs['single'], double: bs['double'], triple: bs['triple'], hr: bs['hr'], bb: bs['bb'], rbi: bs['rbi'], so: bs['so'], avg: bs['avg'], r: bs['r'], sb: bs['sb'], hbp: bs['hbp']}
    end
    return stats_hash
  end

  def self.calculateFantasyPoints(stats_hash)
    single = stats_hash[:single].to_i * 1
    double = stats_hash[:double].to_i * 2
    triple = stats_hash[:triple].to_i * 3
    home_run = stats_hash[:hr].to_i * 4
    run = stats_hash[:r].to_i * 1
    walk = stats_hash[:bb].to_i * 1
    hit_by_pitch = stats_hash[:hbp].to_i * 1
    stolen_base = stats_hash[:sb].to_i * 1
    rbi = stats_hash[:rbi].to_i * 1
    strike_out = stats_hash[:so].to_i * 0.5
    fantasy_points = single + double + triple + home_run + run + walk + hit_by_pitch + stolen_base + rbi - strike_out
    return fantasy_points
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

  #Code for using Gameday API to get the correct team names using the team abbreviation
  # def self.setTeam
  #   Playercard.where("pro_team_name = ?", "TOR").each do |player|
  #     player.update(pro_team_city: "Toranto", pro_team_name: "Blue Jays")
  #   end
  #   Playercard.where("pro_team_name = ?", "CIN").each do |player|
  #     player.update(pro_team_city: "Cincinnati", pro_team_name: "Reds")
  #   end
  #   Playercard.where("pro_team_name = ?", "CLE").each do |player|
  #     player.update(pro_team_city: "Cleveland", pro_team_name: "Indians")
  #   end
  #   Playercard.where("pro_team_name = ?", "ATL").each do |player|
  #     player.update(pro_team_city: "Atlanta", pro_team_name: "Braves")
  #   end
  #   Playercard.where("pro_team_name = ?", "BOS").each do |player|
  #     player.update(pro_team_city: "Boston", pro_team_name: "Red Sox")
  #   end
  #   Playercard.where("pro_team_name = ?", "TEX").each do |player|
  #     player.update(pro_team_city: "Texas", pro_team_name: "Rangers")
  #   end
  #   Playercard.where("pro_team_name = ?", "LAA").each do |player|
  #     player.update(pro_team_city: "Los Angeles", pro_team_name: "Angels")
  #   end
  #   Playercard.where("pro_team_name = ?", "DET").each do |player|
  #     player.update(pro_team_city: "Detroit", pro_team_name: "Tigers")
  #   end
  #   Playercard.where("pro_team_name = ?", "MIA").each do |player|
  #     player.update(pro_team_city: "Miami", pro_team_name: "Marlins")
  #   end
  #   Playercard.where("pro_team_name = ?", "LAD").each do |player|
  #     player.update(pro_team_city: "Los Angeles", pro_team_name: "Dodgers")
  #   end
  #   Playercard.where("pro_team_name = ?", "KC").each do |player|
  #     player.update(pro_team_city: "Kansas City", pro_team_name: "Royals")
  #   end
  #   Playercard.where("pro_team_name = ?", "PHI").each do |player|
  #     player.update(pro_team_city: "Philadelphia", pro_team_name: "Phillies")
  #   end
  #   Playercard.where("pro_team_name = ?", "MIL").each do |player|
  #     player.update(pro_team_city: "Milwaukee", pro_team_name: "Brewers")
  #   end
  #   Playercard.where("pro_team_name = ?", "OAK").each do |player|
  #     player.update(pro_team_city: "Oakland", pro_team_name: "Athletics")
  #   end
  #   Playercard.where("pro_team_name = ?", "ARI").each do |player|
  #     player.update(pro_team_city: "Arizona", pro_team_name: "Diamondbacks")
  #   end
  #   Playercard.where("pro_team_name = ?", "CHC").each do |player|
  #     player.update(pro_team_city: "Chicago", pro_team_name: "Cubs")
  #   end
  #   Playercard.where("pro_team_name = ?", "BAL").each do |player|
  #     player.update(pro_team_city: "Baltimore", pro_team_name: "Orioles")
  #   end
  #   Playercard.where("pro_team_name = ?", "PIT").each do |player|
  #     player.update(pro_team_city: "Pittsburgh", pro_team_name: "Pirates")
  #   end
  #   Playercard.where("pro_team_name = ?", "WSH").each do |player|
  #     player.update(pro_team_city: "Washington", pro_team_name: "Nationals")
  #   end
  #   Playercard.where("pro_team_name = ?", "CWS").each do |player|
  #     player.update(pro_team_city: "Chicago", pro_team_name: "White Sox")
  #   end
  #   Playercard.where("pro_team_name = ?", "STL").each do |player|
  #     player.update(pro_team_city: "Saint Louis", pro_team_name: "Cardinals")
  #   end
  #   Playercard.where("pro_team_name = ?", "SD").each do |player|
  #     player.update(pro_team_city: "San Diego", pro_team_name: "Padres")
  #   end
  #   Playercard.where("pro_team_name = ?", "HOU").each do |player|
  #     player.update(pro_team_city: "Houston", pro_team_name: "Astros")
  #   end
  #   Playercard.where("pro_team_name = ?", "SEA").each do |player|
  #     player.update(pro_team_city: "Seattle", pro_team_name: "Mariners")
  #   end
  #   Playercard.where("pro_team_name = ?", "MIN").each do |player|
  #     player.update(pro_team_city: "Minnesota", pro_team_name: "Twins")
  #   end
  # end
  #Code to see which players played yesterday.
  # def self.yesterdaysPlayers
  #   game_array = yesterdaysGames()
  #   player_array = []
  #   game_array.each do |game|
  #     uri = URI("http://gd2.mlb.com" + game + "/players.xml")
  #     xml_doc = Nokogiri::XML(Net::HTTP.get(uri))
  #     xml_doc.css('game team player').each do |player|
  #       stats = batterStats(player['id'])
  #       data = {name: player['first'] + ' ' + player['last'], id: player['id'], team: player['team_abbrev']}
  #       hash = data.merge!(stats)
  #       player_array.push(hash)
  #     end
  #   end
  #   return player_array
  # end
