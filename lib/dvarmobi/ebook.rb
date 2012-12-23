require 'rpub'

class Ebook
  def self.as_epub(pages)
    Utils.prepare_folder('ebook')
    Rpub::Compressor.open(book.filename) do |zip|
      Rpub::Epub.new(book, source.read(context.styles)).manifest_in(zip)
    end
 end
end
