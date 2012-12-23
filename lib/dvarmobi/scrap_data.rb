class ScrapData
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
      :host => 'http://www.chiefrabbi.org',
      :index => '/category/covenantandconversation/',
      :ix_sel => 'div#content article:first-child a.entry-title',
      :attr => 'href',
      :tx_sel => 'div.entry',
      :remove => [ '.addthis_toolbox', '#attachment_255' ]
    },
    "urj" => {
      :host => 'http://urj.org',
      :index => '/learning/torah/',
      :ix_sel => 'div.Sheet2660 td.cnt1021Content a',
      :attr => 'href',
      :tx_sel => 'div.Content table.body div table tr:nth-child(2) td',
      :remove => [ 'div' ]
    }
  }
  
  def self.get(page)
    return @@scrap_data[page]
  end
  def self.each
    @@scrap_data.each do |key, value|
      yield key, value
    end
  end
end
