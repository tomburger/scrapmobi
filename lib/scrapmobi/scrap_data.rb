class ScrapData
  
  attr_accessor :fname
  attr_accessor :book_title
  
  class PageObj
    def initialize(page)
    end
    def title(title=nil)
      if title.nil?
        @title
      else
        @title = title
      end
    end
    def action(&block)
      if block.nil?
        @action
      else
        @action = block
      end
    end
  end

  def initialize
    @scrap_data = {}
  end
  
  def add(page) 
    page_obj = PageObj.new(page) 
    yield page_obj
    @scrap_data.store(page, page_obj)
  end

  def filename(fname)
    @fname = fname
  end
  def title(title)
    @book_title = title
  end

  def get(page)
    return @scrap_data[page]
  end
  def page_title(page)
    return get(page).title
  end
  def action(page)
    return get(page).action
  end
  def each
    @scrap_data.each do |key, value|
      yield key, value.title
    end
  end
  def keys
    @scrap_data.keys
  end
  
  @@config = nil
  def self.config
    return @@config
  end
  def self.prepare
    f = Fiber.new do
      str = File.read('./Scrapmobi.config')
      #$SAFE = 4
      config = ScrapData.new
      config.instance_eval(str)
      Fiber.yield config
    end
    @@config = f.resume
  end
end
