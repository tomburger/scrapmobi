class ScrapData

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
  
  def get(page)
    return @scrap_data[page]
  end
  def title(page)
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
  
  @@config = nil
  def self.config
    return @@config
  end
  def self.prepare
    f = Fiber.new do
      str = File.read('./Dvarmobi.config')
      #$SAFE = 4
      config = ScrapData.new
      config.instance_eval(str)
      Fiber.yield config
    end
    @@config = f.resume
  end
end
