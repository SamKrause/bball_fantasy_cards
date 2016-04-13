class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def dailyGameDirectories
    uri = URI("http://gd2.mlb.com/components/game/mlb/year_2016/month_04/day_11/epg.xml")
    Net::HTTP.get(uri)
  end


end
