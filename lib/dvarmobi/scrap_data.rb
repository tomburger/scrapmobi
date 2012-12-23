class ScrapData
  @@scrap_data = {}

  class PageObj
    def initialize(page)
      @data = {}
    end
    def method_missing(name, *args)
      if (args.length == 0)
        return @data[name]
      else
        @data[name] = args[0]
        return self
      end
    end
    def each 
      @data.each do |key,value|
        yield key,value
      end
    end
  end

  def self.add(page) 
    page_obj = PageObj.new(page) 
    yield page_obj
    @@scrap_data[page] = page_obj
  end
  
  def self.get(page)
    return @@scrap_data[page]
  end
  def self.each
    @@scrap_data.each do |key, value|
      yield key, value
    end
  end
end
