class Pages
  def self.print(pages=nil)
    if (pages == nil)
      puts 'Pages available'
      ScrapData.each do |key, value|
        puts "#{key}: #{value.title}"
      end
    else
      pages.each do |page|
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
