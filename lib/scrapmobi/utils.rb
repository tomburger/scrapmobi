class Utils
  def self.prepare_folder(name)
    if !(File.exists?(name)) 
      Dir.mkdir(name)
    else
      Dir.foreach(name) do |f|
        if f!= '.' && f != '..'
          fn = File.join(name, f)
          File.delete(fn)
        end
      end
    end
  end
end
