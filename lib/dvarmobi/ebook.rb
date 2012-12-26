require 'zip/zipfilesystem'
require 'zip/zip'

class Ebook
  def self.as_epub(pages)
    Utils.prepare_folder('ebook')
    Zip::ZipFile.open('./ebook/dvarmobi.epub', Zip::ZipFile::CREATE) do |z|
      z.get_output_stream('mimetype') { |f| f.puts 'application/epub+zip' }
      z.mkdir('META-INF')
      z.add('META-INF/container.xml', './template/container.xml.template')
      z.mkdir('OEBPS')
      prepare_opf(z, pages)
      prepare_ncx(z, pages)
      pages.each do |p|
        f = p + '.xhtml'
        z.add('OEBPS/'+f,'./scrap/'+f)
      end
    end
  end
  def self.prepare_opf(z, pages)
    z.get_output_stream('OEBPS/Content.opf') do |f|
      opf = File.read('./template/Content.opf.template')
     
      manifest = ''
      spine = ''
      pages.each do |p|
        manifest += "<item id='#{p}' href='#{p}.xhtml' media-type='application/xhtml+xml' />"
        spine += "<itemref idref='#{p}' />"
      end
        
      opf.gsub!('#MANIFEST', manifest)
      opf.gsub!('#SPINE', spine)
     
      f.puts opf
    end
  end
  def self.prepare_ncx(z, pages)
    z.get_output_stream('OEBPS/toc.ncx') do |f|
      toc = File.read('./template/toc.ncx.template')
      np_temp = File.read('./template/navpoint.ncx.template')
      
      navpoints = ''
      i = 0
      pages.each do |p|
        dt = ScrapData.config.get(p)
        np = np_temp.dup
        i += 1
        
        np.gsub!('#ID', p)
        np.gsub!('#INDEX', i.to_s)
        np.gsub!('#TITLE', dt.title)
        
        navpoints += np
      end
      
      toc.gsub!('#NAVPOINTS', navpoints)
      
      f.puts toc
    end
  end
end
