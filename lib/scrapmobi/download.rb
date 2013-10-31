
require 'open-uri'
require 'nokogiri'
require 'cgi'
class Downloader
  attr_reader :img
  def initialize(page)
    @page = page
    @host = ''
    @url = ''
    @html = nil
    @img = {}
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
    puts "Downloading #{@url}"
    @html = Nokogiri::HTML(open(@url))
    @url = ''
    return self
  end
  def load_file(fname)
    File.open(fname, 'r') do |f|
      @html = Nokogiri::HTML(f)
    end
    @url = ''
    return self
  end
  def get_link(selector)
    if (selector.is_a?(Regexp))
	  if (selector =~ @html.to_xhtml)
	    @url = @host+"/"+$~[1]
		@html = nil
	  end
	else
	  link = @html.at_css(selector)
	  @url = link['href']
	  @url=@host+@url if (@url[0,4].downcase!='http')
	  @html = nil
    end
	return self
  end
  def get_content(selector)
    @html = @html.css(selector)
    return self
  end
  def first_only
    @html = @html.first
	return self
  end
  def step_in
    @html = @html.children
    return self
  end
  def remove(selector)
    @html.css(selector).remove
    return self
  end
  def images()
    ix = 0
    @html.css('img').each do |i| 
      ix += 1
      im_name = @page + ix.to_s + ".jpg"
      @img[im_name] = i['src'] 
      i['src'] = im_name
      puts "Image #{im_name} replacement for #{@img[im_name]}"
    end
    return self
  end
  def to_text
    txt = @html.to_xhtml
    txt = txt.encode("UTF-8")
    txt = CGI.unescapeHTML(txt)
    return txt 
  end
end

class Download
  def self.download(args)
    args.each do |page|
      action = ScrapData.config.action(page)
      content = Downloader.new(page)
      action.call(content)
      yield page, content.to_text, content.img
    end
  end
end
