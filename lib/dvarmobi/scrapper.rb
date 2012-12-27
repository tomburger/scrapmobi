require 'erubis'

class Scrapper
  def self.run(args)
    Utils.prepare_folder('scrap')
    Download.download(args) do |page, content|
      p = ScrapData.config.get(page)
      tmp = Erubis::Eruby.new(Templates.chapter)
      File.open("scrap/"+page+".xhtml", "w+") do |f|
        f.write tmp.result(:title=>p.title,:content=>content)
      end
    end
  end
end
