class ScrapData

  class PageObj
    def initialize(page)
      @data = {}
    end
    def method_missing(name, *args)
      if (args.length == 0)
        return @data[name]
      else
        @data.store(name, args[0])
        return self
      end
    end
    def each 
      @data.each do |key,value|
        yield key,value
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
  def each
    @scrap_data.each do |key, value|
      yield key, value
    end
  end
  
  @@config = nil
  def self.config
    return @@config
  end
  def self.prepare
    f = Fiber.new do
      config = ScrapData.new
      str = File.read('./Dvarmobi.config')
      #$SAFE = 4
      config.instance_eval(str)
      Fiber.yield config
    end
    @@config = f.resume
  end
end
