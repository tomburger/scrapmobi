require 'open-uri'
require 'nokogiri'

class Download
  def self.prepare_folder
    if !(File.exists?("scrap")) 
      Dir.mkdir("scrap")
    else
      Dir.foreach("scrap") do |f|
        if f!= '.' && f != '..'
          fn = File.join("scrap", f)
          File.delete(fn)
        end
      end
    end
  end
  def self.download(args)
    args.each do |page|
      content = Download.download_one(page)
      yield page, content
    end
  end
  def self.download_one(page)
    pg_data = ScrapData.get(page)
    
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
    text = tx_page.at_css(pg_data.tx_sel)
    
    # remove not wanted pieces
    pg_data.remove.each do |selector|
      text.css(selector).remove()
    end
    
    return text.to_html() 
  end
  
  def self.print_pages(args=nil)
    if (args == nil)
      puts 'Pages available'
      ScrapData.each do |key, value|
        puts "#{key}: #{value.title}"
      end
    else
      args.each do |page|
        pg_data = ScrapData.get(page)
        puts pg_data.title
        puts '================================'
        pg_data.each do |key,value|
          puts "  #{key}: #{value}" if key != 'title'
        end
        puts
      end
    end
  end
end
