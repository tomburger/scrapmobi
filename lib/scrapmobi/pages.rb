class Pages
  def self.print
    puts 'Pages available'
    ScrapData.config.each do |key, title|
      puts "#{key}: #{title}"
    end
  end
end
