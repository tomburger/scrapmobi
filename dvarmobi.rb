ScrapData.add("ohr") do |p|
  p.title   'OHR'
  p.host    'http://ohr.edu'
  p.index   '/this_week/torah_weekly/'
  p.ix_sel  'div.latest_in_series a'
  p.attr    'href'
  p.tx_sel  'div#text'
  p.remove  [ '.noprint' ]
end

ScrapData.add("sacks") do |p|
  p.title   'Covenant and Conversation'
  p.host    'http://www.chiefrabbi.org'
  p.index   '/category/covenantandconversation/'
  p.ix_sel  'div#content article:first-child a.entry-title'
  p.attr    'href'
  p.tx_sel  'div.entry'
  p.remove  [ '.addthis_toolbox', '#attachment_255' ]
end

ScrapData.add("urj") do |p|
  p.title   'Union of Reform Judaism'
  p.host    'http://urj.org'
  p.index   '/learning/torah/'
  p.ix_sel  'div.Sheet2660 td.cnt1021Content a'
  p.attr    'href'
  p.tx_sel  'div.Content table.body div table tr:nth-child(2) td'
  p.remove  [ 'div' ]
end


