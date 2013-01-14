require 'erubis'

class Scrapper
  def self.run(args)
    Utils.prepare_folder('scrap')
    Download.download(args) do |page, content, images|
      t = ScrapData.config.title(page)
      tmp = Erubis::Eruby.new(Templates.chapter)
      File.open("scrap/"+page+".xhtml", "w+") do |f|
        f.write tmp.result(:title=>t,:content=>content)
      end
      images.each do |name, url|
        File.open("scrap/"+name, "wb") do |f|
          puts "Downloading #{url}"
          open(url, "rb") do |i|
            f.write(i.read)
          end
        end
      end
    end
  end
end
