require 'date'
require 'json'
require 'rest_client'

class HebCal
  
  @@torah = {
    "bereishit" => "GN1:1-6:8",
    "noach" => "GN6:9-11:32",
    "lech-lecha" => "GN12:1-17:27",
    "vayeira" => "GN18:1-22:24",
    "chayei-sarah" => "GN23:1-25:18",
    "toledot" => "GN25:19-28:9",
    "vayetze" => "GN28:10-32:3",
    "vayishlach" => "GN32:4-36:43",
    "vayeshev" => "GN37:1-40:23",
    "miketz" => "GN41:1-44:17",
    "vayigash" => "GN44:18-47:27",
    "vayechi" => "GN47:28-50:26",
    
    "shemot" => "EX1:1-6:1",
    "va-eira" => "EX6:2-9:35",
    "bo" => "EX10:1-13:16",
    "beshalach" => "EX13:17-17:16",
    "yitro" => "EX18:1-20:23",
    "mishpatim" => "EX21:1-24:18",
    "terumah" => "EX25:1-27:19",
    "tetzaveh" => "EX27:20-30:10",
    "ki-tisa" => "EX30:11-34:35",
    "vayakhel" => "EX35:1-38:20",
    "pekudei" => "EX38:21-40:38",
    
    "vayikra" => "LV1:1-5:26",
    "tzav" => "LV6:1-8:36",
    "shemini" => "LV9:1-11:47",
    "tazria" => "LV12:1-13:59",
    "metzora" => "LV14:1-15:33",
    "acharei-mot" => "LV16:1-18:30",
    "kedoshim" => "LV19:1-20:27",
    "emor" => "LV21:1-24:23",
    "behar" => "LV25:1-26:2",
    "bechukotai" => "LV26:3-27:34",
    
    "bamidbar" => "NM1:1-4:20",
    "naso" => "NM4:21-7:89",
    "behaalotecha" => "NM8:1-12:16",
    "shlach" => "NM13:1-15:41",
    "korach" => "NM16:1-18:32",
    "chukat" => "NM19:1-22:1",
    "balak" => "NM22:2-25:9",
    "pinchas" => "NM25:10-30:1",
    "matot" => "NM30:2-32:42",
    "masei" => "NM33:1-36:13",
    
    "devarim" => "DT1:1-3:22",
    "va-etchanan" => "DT3:23-7:11",
    "eikev" => "DT7:12-11:25",
    "re-eh" => "DT11:26-16:17",
    "shoftim" => "DT16:18-21:9",
    "ki-teitzei" => "DT21:10-25:19",
    "ki-tavo" => "DT26:1-29:8",
    "nitzavim" => "DT29:9-30:20",
    "vayelech" => "DT31:1-31:30",
    "haazinu" => "DT32:1-32:52",
    "v-zot-haberachah" => "DT33:1-34:12"
    
  }
  
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
      result = p["link"] if (d1..d2).include? date 
    end
    if result.empty?
      d = date + 7   # saturday could alredy be within next month
      result = current_parasha(d) if m < d.month
    end
    raise "Parasha for day #{date} not found" if result.empty? 
    return result[/(\w)+$/] # last word of the link (after last "/")
  end
  
  def self.torah_portion(parasha)
    if @@torah.include? parasha
      @@torah[parasha]
    else
      raise "Unknown parasha #{parasha}"
    end
  end
  
  def self.link_to_parasha(version)
    "/passage/?search=#{torah_portion(current_parasha(Date.today))}&version=#{version}"
  end
  
end
