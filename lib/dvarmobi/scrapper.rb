class Scrapper
  def self.run(args)
    Utils.prepare_folder('scrap')
    Download.download(args) do |page, content|
      File.open("scrap/"+page+".html", "w+") do |f|
        f.write("<htm><body>#{content}</body></html>")
      end
    end
  end
end
