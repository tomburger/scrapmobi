require 'open-uri'
require 'nokogiri'
require 'cgi'
class Downloader
  def initialize
    @host = ''
    @url = ''
    @html = nil
  end
  def set_host(host)
    @host = host
    return self
  end
  def start_with(url)
    @url = @host+url
    return self
  end
  def get_page
    @html = Nokogiri::HTML(open(@url))
    @url = ''
    return self
  end
  def get_link(selector)
    link = @html.at_css(selector)
    @url = link['href']
    @url=@host+@url if (@url[0,4].downcase!='http')
    @html = nil
    return self
  end
  def get_content(selector)
    @html = @html.css(selector)
    return self
  end
  def remove(selector)
    @html.css(selector).remove
    return self
  end
  def to_text
    txt = @html.to_html
    txt = txt.encode("UTF-8")
    txt = CGI.unescapeHTML(txt)
    return txt 
  end
end

class Download
  def self.download(args)
    args.each do |page|
      pg_data = ScrapData.config.get(page)
      content = Downloader.new
      content.set_host(pg_data.host)
             .start_with(pg_data.index)
             .get_page
             .get_link(pg_data.ix_sel)
             .get_page
             .get_content(pg_data.tx_sel)
      pg_data.remove.each do |selector|
        content.remove(selector)
      end
      yield page, content.to_text
    end
  end
end
