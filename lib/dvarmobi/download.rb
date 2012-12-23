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
    page = ScrapData.get(page)
    
    # get index page, which is always the same, find the link to current page
    index = Nokogiri::HTML(open(page[:host]+page[:index]))
    link = index.at_css(page[:ix_sel])
    tx_url = link[page[:attr]]
    
    # prepend relative URL with host 
    if (page[:host]!=tx_url[0,page[:host].length]) 
      tx_url = page[:host]+tx_url 
    end
    
    # get actual page with content
    tx_page = Nokogiri::HTML(open(tx_url))
    text = tx_page.at_css(page[:tx_sel])
    
    # remove not wanted pieces
    page[:remove].each do |selector|
      text.css(selector).remove()
    end
    
    return text.to_html() 
  end
  def self.print_pages
    puts 'Pages available'
    ScrapData.each do |key, value|
      puts key
    end
  end
end
