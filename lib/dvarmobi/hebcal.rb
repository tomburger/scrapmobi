require 'date'
require 'json'
require 'rest_client'

class HebCal
  def self.current_parasha(date)
    m = date.month
    y = date.year
    u = "http://www.hebcal.com/hebcal/?v=1;cfg=json;year=#{y};month=#{m};s=on;i=off;c=off"
    r = RestClient.get u
    j = JSON.parse r
    result = ''
    j["items"].each do |p|
      d2 = Date.parse(p["date"])
      d1 = d2 - 6
      result = p["title"] if (d1..d2).include? date 
    end
    return result
  end
end
