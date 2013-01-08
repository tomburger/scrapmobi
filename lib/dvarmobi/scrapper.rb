require 'erubis'

class Scrapper
  def self.run(args)
    Utils.prepare_folder('scrap')
    Download.download(args) do |page, content|
      t = ScrapData.config.title(page)
      tmp = Erubis::Eruby.new(Templates.chapter)
      File.open("scrap/"+page+".xhtml", "w+") do |f|
        f.write tmp.result(:title=>t,:content=>content)
      end
    end
  end
end
