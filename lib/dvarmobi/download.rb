require 'open-uri'
require 'nokogiri'

class Download
  def self.download(args)
    args.each do |page|
      content = download_one(page)
      content = convert(page, content)
      yield page, content
    end
  end
  def self.download_one(page)
    pg_data = ScrapData.config.get(page)
    
    # get index page, which is always the same, find the link to current page
    index = Nokogiri::HTML(open(pg_data.host+pg_data.index))
    link = index.at_css(pg_data.ix_sel)
    tx_url = link[pg_data.attr]
    
    # prepend relative URL with host 
    if (pg_data.host!=tx_url[0,pg_data.host.length]) 
      tx_url = pg_data.host+tx_url 
    end
    
    # get actual page with content
    tx_page = Nokogiri::HTML(open(tx_url))
    
    return tx_page.at_css(pg_data.tx_sel)
  end 
  def self.convert(page, text)
    pg_data = ScrapData.config.get(page)
    
    # remove not wanted pieces
    pg_data.remove.each do |selector|
      text.css(selector).remove()
    end
    
    return text.to_html() 
  end
end
