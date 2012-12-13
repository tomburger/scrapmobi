require 'open-uri'
require 'nokogiri'

class Download
  @@scrap_data = {
    "ohr" => {
      :host => 'http://ohr.edu',
      :index => '/this_week/torah_weekly/',
      :ix_sel => 'div.latest_in_series a',
      :attr => 'href',
      :tx_sel => 'div#text',
      :remove => [ '.noprint' ]
    },
    "sacks" => {
      :host => 'http://www.chiefrabbi.org/',
      :index => '/category/covenantandconversation/',
      :ix_sel => 'div#content article:first-child a.entry-title',
      :attr => 'href',
      :tx_sel => 'div.entry',
      :remove => [ '.addthis_toolbox', '#attachment_255' ]
    }
  } 
  def self.download(page)
    page = @@scrap_data[page]
    
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
end
