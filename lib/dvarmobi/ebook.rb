require 'zip/zipfilesystem'
require 'zip/zip'
require 'open3'
require 'erubis'

class Ebook
  def self.as_epub(pages)
    Utils.prepare_folder('ebook')
    Zip::ZipFile.open('./ebook/dvarmobi.epub', Zip::ZipFile::CREATE) do |z|
      z.get_output_stream('mimetype') { |f| f.puts 'application/epub+zip' }
      z.mkdir('META-INF')
      z.get_output_stream('META-INF/container.xml') { |f| f.puts Templates.container }
      z.mkdir('OEBPS')
      z.get_output_stream('OEBPS/content.opf') { |f| f.puts prepare_opf(pages) }
      z.get_output_stream('OEBPS/toc.ncx') { |f| f.puts prepare_ncx(pages) }
      z.get_output_stream('OEBPS/styles.css') { |f| f.puts Templates.styles }
      pages.each do |p|
        f = p + '.xhtml'
        z.add('OEBPS/'+f,'./scrap/'+f)
      end
    end
  end
  def self.to_mobi
    stdout_str, stderr_str, status = Open3.capture3('kindlegen ./ebook/dvarmobi.epub')
  end
  def self.prepare_opf(pages)
    opf = Erubis::Eruby.new(Templates.content)
    man_tmp = Erubis::Eruby.new(Templates.manifest)
    spine_tmp = Erubis::Eruby.new(Templates.spine)
   
    manifest = ''
    spine = ''
    pages.each do |p|
      manifest += man_tmp.result(:page=>p)
      spine += spine_tmp.result(:page=>p)
    end
    
    return opf.result(:manifest=>manifest,:spine=>spine)
  end
  def self.prepare_ncx(pages)
    toc = Erubis::Eruby.new(Templates.toc)
    np_tmp = Erubis::Eruby.new(Templates.navpoint)
    
    navpoints = ''
    i = 0
    pages.each do |p|
      t = ScrapData.config.title(p)
      i += 1
      navpoints += np_tmp.result(:id=>p,:index=>i, :title=>t)
    end
    
    return toc.result(:navpoints=>navpoints)
  end
end
