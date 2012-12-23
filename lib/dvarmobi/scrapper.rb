class Scrapper
  def self.run(args)
    Download.prepare_folder()
    Download.download(args) do |page, content|
      File.open("scrap/"+page+".html", "w+") do |f|
        f.write(content)
      end
    end
  end
end
