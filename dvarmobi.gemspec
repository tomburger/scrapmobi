# Ensure we require the local version and not one we might have installed already
require File.join([File.dirname(__FILE__),'lib','dvarmobi','version.rb'])
spec = Gem::Specification.new do |s| 
  s.name = 'dvarmobi'
  s.version = Dvarmobi::VERSION
  s.author = 'Your Name Here'
  s.email = 'your@email.address.com'
  s.homepage = 'http://your.website.com'
  s.platform = Gem::Platform::RUBY
  s.summary = 'A description of your project'
# Add your other files here if you make them
  s.files = %w(
    bin/dvarmobi
    lib/dvarmobi/version.rb
    lib/dvarmobi/download.rb
    lib/dvarmobi.rb
  )
  s.require_paths << 'lib'
  s.has_rdoc = true
  s.extra_rdoc_files = ['README.rdoc','dvarmobi.rdoc']
  s.rdoc_options << '--title' << 'dvarmobi' << '--main' << 'README.rdoc' << '-ri'
  s.bindir = 'bin'
  s.executables << 'dvarmobi'
  s.add_development_dependency('rake')
  s.add_development_dependency('rdoc')
  s.add_development_dependency('aruba')
  s.add_runtime_dependency('gli','2.5.0')
  s.add_runtime_dependency('nokogiri','1.5.5')
  s.add_runtime_dependency('rubyzip') 
  s.add_runtime_dependency('erubis')
  s.add_runtime_dependency('rest-client')
  s.add_runtime_dependency('json')
end
