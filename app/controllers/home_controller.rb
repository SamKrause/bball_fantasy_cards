class HomeController < ApplicationController
  def index
    $rankings
    #$list
  end

  def ranking
    response = JSON.parse(playerRanking())
    $rankings = response['body']['rankings']['positions']
    redirect_to '/'
  end

  def playerRanking
    uri = URI("http://api.cbssports.com/fantasy/players/rankings?version=3.0&response_format=JSON&SPORT=baseball")
    Net::HTTP.get(uri)
  end

  # def playerList
  #   uri = URI("http://api.cbssports.com/fantasy/players/list?version=3.0&response_format=JSON&SPORT=baseball")
  #   Net::HTTP.get(uri)
  # end

  # def list
  #   response = JSON.parse(playerList())
  #   $list = response['body']['players']
  #   redirect_to '/'
  # end
end
